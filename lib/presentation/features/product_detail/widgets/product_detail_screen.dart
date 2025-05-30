import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/widgets/item_card.dart';
import 'package:store/domain/domain_models/product.dart';
import 'package:store/presentation/features/product_detail/cubit/product_detail_cubit.dart';
import 'package:store/widgets/custom_error_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String id = '/product_detail_screen';
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments;
    return PlatformScaffold(
      // appBar: PlatformAppBar(title: Text('Product Details')),
      body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailInitial) {
            context.read<ProductDetailCubit>().loadProductDetail(productId);
          }
          if (state is ProductDetailLoading) {
            return Center(
              child: Skeletonizer(
                enabled: true,
                child: _buildProductDetail(context),
              ),
            );
          }
          return state is ProductDetailLoaded
              ? _buildProductDetail(context, state.product)
              : state is ProductDetailError
              ? CustomErrorWidget(message: state.message)
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProductDetail(BuildContext context, [Product? product]) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        PlatformSliverAppBar(
          title: const Text(
            'Product Details',
            // style: TextStyle(color: context.colorScheme.primary),
          ),

          material: (context, platform) {
            return MaterialSliverAppBarData(
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: CustomCachedNetworkImage(
                  height: 250,
                  imageUrl:
                      product?.imageUrl ?? 'https://via.placeholder.com/150',
                ),
              ),
            );
          },
          cupertino: (context, platform) {
            return CupertinoSliverAppBarData(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(250),
                child: CustomCachedNetworkImage(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  imageUrl: product?.imageUrl ?? '',
                ),
              ),
            );
          },
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Product Name', style: TextStyle(fontSize: 24)),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Product Description', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
