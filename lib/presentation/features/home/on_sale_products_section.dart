import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/config/dependency_injection.dart';
import 'package:store/core/widgets/horizontal_item_list_view_builder.dart';
import 'package:store/domain/domain_models/section.dart';
import 'package:store/domain/domain_models/product.dart';
import 'package:store/presentation/features/home/cubits/getProductsCubit/product_cubit.dart';
import 'package:store/presentation/features/home/cubits/homeScreenCubit/home_cubit.dart';
import 'package:store/presentation/features/home/home_section_widget.dart';

class OnSaleProductsSection extends StatelessWidget {
  const OnSaleProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          return const Center(child: Text('Initial Loading products'));
        }
        if (state is ProductLoading) {
          return Skeletonizer(
            enabled: true,
            child: HomeSectionWidget(
              section: Section.empty(),
              title: 'On Sale Products',
              actionText: 'See All',
              child: ItemListViewHorizontalBuilder(
                products: List.generate(10, (i) => ProductBuiler().build()),
              ),
            ),
          );
        }

        // if (state is ProductError) {
        //   return Center(child: Text('Error: ${state.message}'));
        // }

        final List<Product> products =
            state is ProductLoaded ? state.onSaleProducts : [];
        if (products.isEmpty) {
          return const Center(child: Text('No products available.'));
        }
        // Display the list of products
        return HomeSectionWidget(
          section: Section.empty(),
          title: 'On Sale Products',
          actionText: 'See All',
          onPressedAction: () {
            // Handle action button press
          },
          child: ItemListViewHorizontalBuilder(
            products: products,
            padding: const EdgeInsets.only(bottom: 10),
          ),
        );
      },
    );
  }
}
