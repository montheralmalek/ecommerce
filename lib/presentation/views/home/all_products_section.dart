import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/services/dependency_injection.dart';
import 'package:store/core/widgets/items_list_sliver_grid_builder.dart';
import 'package:store/domain/entities/product_entity.dart';
import 'package:store/presentation/cubits/product_cubit.dart';
import 'package:store/presentation/viewmodels/product_view_model.dart';
import 'package:store/presentation/views/home/home_section_widget.dart';

class AllProductsSection extends StatelessWidget {
  const AllProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final viewModel = getIt<ProductViewModel>();

        if (state is ProductInitial) {
          return SliverToBoxAdapter(
            child: const Center(child: Text('No products loaded.')),
          );
        }
        if (state is ProductLoading) {
          return Skeletonizer(
            enabled: true,
            child: HomeSectionWidget(
              title: 'All Products',
              child: ItemsListGridBuilder(
                productsList: List.generate(
                  10,
                  (i) => ProductEntitBuiler().build(),
                ),
              ),
            ),
          );
        }

        if (state is ProductError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        final List<ProductEntity> products =
            state is ProductLoaded ? state.allProducts : [];
        if (products.isEmpty) {
          return const Center(child: Text('No products available.'));
        }
        // Display the list of products
        return HomeSectionWidget(
          title: 'All Products',
          child: ItemsListGridBuilder(productsList: products),
        );
      },
    );
  }
}
