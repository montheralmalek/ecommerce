import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:store/core/themes/dimens.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/core/utils/extensions/widget_extensions.dart';
import 'package:store/core/widgets/input_quantity.dart';
import 'package:store/domain/entities/product/product.dart';
import 'package:store/core/widgets/widgets.dart';
import 'package:store/ui/features/cart/cubits/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:store/ui/features/cart/views/spacers.dart';
import 'package:store/ui/widgets/item_card_horizontal.dart';

/// On add to Cart button pressed function
/// Shows a bottom sheet dialog to select available options like quantity and confirm adding to cart
/// @param context BuildContext
/// @param product Product to be added to cart
/// @param initialQuantity Initial quantity to be selected in the dialog
void addToCartDialog(
  BuildContext context,
  Product product,
  int initialQuantity,
) {
  showPlatformModalSheet(
    context: context,
    // isScrollControlled: true,
    builder: (context) {
      return BottomSheet(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        constraints: BoxConstraints(maxHeight: context.height * 0.9),
        clipBehavior: Clip.antiAlias,
        onClosing: () {},
        builder: (context) {
          return AddToCartOptionsSheet(
            product: product,
            initialQuantity: initialQuantity,
          );
        },
      );
    },
    material: MaterialModalSheetData(
      isScrollControlled: true,
      backgroundColor: context.theme.scaffoldBackgroundColor,
    ),
    cupertino: CupertinoModalSheetData(),
  );
}

/// Add to cart options widget
class AddToCartOptionsSheet extends StatelessWidget {
  const AddToCartOptionsSheet({
    super.key,
    required this.product,
    this.initialQuantity = 1,
  });
  final Product product;
  final int initialQuantity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToCartCubit(product: product),
      child: Column(
        children: [
          ListTile(
            minTileHeight: 70,
            tileColor: context.colorScheme.primary.withAlpha(30),
            splashColor: context.colorScheme.primary.withAlpha(30),

            leading: BackButton(),
            title: Text(product.title),
          ),
          SizedBox(height: Dimens.of(context).paddingMedium),
          //
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
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
              child: CustomButton.filled(
                expanded: true,
                height: double.maxFinite,
                broderRadius: BorderRadius.zero,
                label: 'Done',
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
