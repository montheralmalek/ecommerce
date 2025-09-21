import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/themes/dimens.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/utils/extensions/widget_extensions.dart';
import 'package:store/core/widgets/custom_button.dart';
import 'package:store/core/widgets/input_quantity.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/ui/features/cart/cubits/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:store/ui/features/cart/views/spacers.dart';
import 'package:store/ui/widgets/item_card_horizontal.dart';

class AddToCartView extends StatelessWidget {
  static const String id = '/add_to_cart_view';
  const AddToCartView({super.key, required this.productId});
  final int productId;
  @override
  Widget build(BuildContext context) {
    final product = GoRouterState.of(context).extra as Product;
    return BlocProvider(
      create: (context) => AddToCartCubit(product: product),
      child: PlatformScaffold(
        // appBar: PlatformAppBar(title: PlatformText(product.title)),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  PlatformSliverAppBar(
                    title: PlatformText(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ItemCradHorizontal(
                    product: product,
                    showAddToCartButton: false,
                  ).withScreenPaddingHorizontal(context).toSliver,

                  Spacers.horizontalSmall().toSliver,
                  QuantitySelector()
                      .withScreenPaddingHorizontal(context)
                      .toSliver,
                  Spacers.horizontalSmall().toSliver,
                  if (product.hasSize)
                    SizeSelector(
                      sizes: product.sizes!,
                    ).withScreenPaddingHorizontal(context).toSliver,
                  SliverFillRemaining(),
                ],
              ),
            ),

            ///
            if (product.isAvailableInStock)
              _buildAddToCartButton(context, product),
          ],
        ),
      ),
    );
  }
}

/// Quantity selector widget
class QuantitySelector extends StatelessWidget {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddToCartCubit, AddToCartState, int>(
      selector: (state) => state.quantity,
      builder: (context, quantity) {
        return Row(
          children: [
            const Text('Quantity:'),
            const SizedBox(width: 10),
            InputQuantity(
              initialValue: quantity,
              onChanged: context.read<AddToCartCubit>().updateQuantity,
            ),
          ],
        );
      },
    );
  }
}

/// Size selector widget
class SizeSelector extends StatelessWidget {
  const SizeSelector({super.key, required this.sizes});

  final List<String> sizes;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddToCartCubit, AddToCartState, String?>(
      selector: (state) => state.selectedSize,
      builder: (context, selectedSize) {
        return Row(
          children: [
            const Text('Size:'),
            ...sizes.map((size) {
              final isSelected = size == selectedSize;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(size),
                  selected: isSelected,
                  onSelected: (_) {
                    context.read<AddToCartCubit>().selectSize(size);
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

// Total price widget
class _TotalPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddToCartCubit, AddToCartState, double>(
      selector: (state) => state.totalPrice,
      builder: (context, totalPrice) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${totalPrice.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Text('Total Price'),
          ],
        );
      },
    );
  }
}

Widget _buildAddToCartButton(BuildContext context, Product product) {
  return Container(
    color: context.colorScheme.surface,
    child: Padding(
      padding: EdgeInsets.only(
        left: Dimens.of(context).paddingLarge,
        right: Dimens.of(context).paddingLarge,
        top: Dimens.of(context).paddingMedium,
        bottom:
            context.mediaQuery.padding.bottom > 0
                ? context.mediaQuery.padding.bottom
                : Dimens.of(context).paddingMedium,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                color: context.colorScheme.primary.withAlpha(40),
                child: _TotalPrice(),
              ),
            ),

            Expanded(
              child: CustomButton(
                height: double.maxFinite,
                broderRadius: BorderRadius.zero,
                label: 'Add To Cart',
                onPressed: () {
                  // NavigationHelper.of(context).goToAddToCartScreen(product);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
