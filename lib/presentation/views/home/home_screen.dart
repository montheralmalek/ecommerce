import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/services/dependency_injection.dart';
import 'package:store/core/utils/extensions/widget_extensions.dart';
import 'package:store/domain/entities/home_section_entity.dart';
import 'package:store/domain/entities/product_entity.dart';
import 'package:store/presentation/cubits/product_cubit.dart';
import 'package:store/presentation/views/home/all_products_section.dart';
import 'package:store/presentation/views/home/banner_slider.dart';
import 'package:store/presentation/views/home/on_sale_products_section.dart';
import 'package:store/presentation/views/home/popular_products_section.dart';
import 'package:store/widgets/sliver_spacer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String id = '/home';

  @override
  Widget build(BuildContext context) {
    final products = List.generate(
      10,
      (i) => ProductEntitBuiler().setTitle('Title $i for product').build(),
    );
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => getIt<ProductCubit>()..fetchProducts(),
          // ProductCubit(getProducts: getIt<GetProductsUseCase>())
          //   ..fetchProducts(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BuildHomeSections(),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildDynamicSections() {
  //   return BlocBuilder<ProductCubit, ProductState>(
  //     builder: (context, state) {
  //       if (state is ProductInitial) {
  //         return const Center(child: Text('No products loaded.'));
  //       }
  //       if (state is ProductLoading) {
  //         return Skeletonizer(
  //           enabled: true,
  //           child: HorizontalItemListViewBuilder(
  //             products: List.generate(10, (i) => ProductEntitBuiler().build()),
  //           ),
  //         );
  //       }

  //       if (state is ProductError) {
  //         return Center(child: Text('Error: ${state.message}'));
  //       }

  //       final List<HomeSectionEntity> sections =
  //           state is ProductLoaded ? state.sections : [];

  //       // Display the list of products
  //       return CustomScrollView(
  //         slivers: sections
  //             .map(
  //               (section) => SliverToBoxAdapter(
  //                 child: Column(
  //                   children: [
  //                     ListTile(
  //                       title: Text(section.title),
  //                       trailing:
  //                           section.hasAction
  //                               ? TextButton(
  //                                 onPressed: () {
  //                                   // Handle action button press
  //                                 },
  //                                 child: Text(section.actionText!),
  //                               )
  //                               : null,
  //                     ),

  //                     // HomeSectionWidget(section: section),
  //                   ],
  //                 ),
  //               ),
  //             )
  //             .toList()
  //             .separatedBy(const SliverSpacer.vertical(10)),
  //       );
  //     },
  //   );
  // }
}

class BuildHomeSections extends StatelessWidget {
  const BuildHomeSections({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BannerSlider().toSliver,

        const SliverSpacer.vertical(10),
        // Horizontal list of products
        PopularProductsSection().toSliver,
        const SliverSpacer.vertical(10),

        // Horizontal list of products
        OnSaleProductsSection().toSliver,
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        AllProductsSection().toSliver,
      ],
    );
  }
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    this.title = 'Banner',
    this.width = double.infinity,
    this.height = 200,
    this.backgroundColor,
  });
  final double? height, width;
  final Color? backgroundColor;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }
}
