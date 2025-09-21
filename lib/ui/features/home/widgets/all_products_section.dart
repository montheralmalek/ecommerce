import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/ui/widgets/items_list_sliver_grid_builder.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/ui/features/product/cubits/get_products_cubit/product_cubit.dart';

class AllProductsSection extends StatelessWidget {
  const AllProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        // if (state is ProductInitial) {
        //   return const Center(child: Text('Initial Loading products'));
        // }
        // if (state is ProductLoading) {
        //   return Skeletonizer(
        //     enabled: true,
        //     child: HomeSectionWidget(
        //       title: 'All Products',
        //       child: ItemsListGridBuilder(
        //         productsList: List.generate(10, (i) => ProductBuiler().build()),
        //       ),
        //     ),
        //   );
        // }

        final List<Product> products =
            state is ProductLoaded ? state.allProducts : [];
        // if (products.isEmpty) {
        //   return const Center(child: Text('No products available.'));
        // }
        // Display the list of products
        return ItemsListGridBuilder(productsList: products);
        // HomeSectionWidget(
        //   title: 'All Products',
        //   child: ItemsListGridBuilder.sliver(productsList: products),
        // );
      },
    );
  }
}
