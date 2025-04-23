import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/widgets/horizontal_item_list_view_builder.dart';
import 'package:store/domain/entities/product_entity.dart';
import 'package:store/presentation/cubits/product_cubit.dart';
import 'package:store/presentation/views/home/home_section_widget.dart';

class PopularProductsSection extends StatelessWidget {
  const PopularProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          return const Center(child: Text('No products loaded.'));
        }
        if (state is ProductLoading) {
          return Skeletonizer(
            enabled: true,
            child: HomeSectionWidget(
              title: 'title',
              actionText: 'See All',
              child: HorizontalItemListViewBuilder(
                products: List.generate(
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
            state is ProductLoaded ? state.popularProducts : [];
        if (products.isEmpty) {
          return const Center(child: Text('No products available.'));
        }
        // Display the list of products
        return HomeSectionWidget(
          title: 'Most Popular Products',
          actionText: 'See All',
          onPressedAction: () {
            // Handle action button press
          },
          child: HorizontalItemListViewBuilder(
            products: products,
            padding: const EdgeInsets.only(bottom: 10),
          ),
        );
      },
    );
  }
}
