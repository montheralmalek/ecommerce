import 'package:flutter/material.dart';
import 'package:store/core/themes/dimens.dart';

extension WidgetExtensionX on Widget {
  /// Wraps the widget with a [SliverToBoxAdapter].
  Widget get toSliver {
    return SliverToBoxAdapter(child: this);
  }

  /// Wraps the widget with a [Material] widget if the [condition] is true.
  /// This is useful when you want to apply material effects like ripple on tap.
  Widget withMaterial(bool condition) {
    if (condition) {
      return Material(type: MaterialType.transparency, child: this);
    }
    return this;
  }

  /// Wraps the widget with screen padding horizontal.
  /// The padding value is taken from the [Dimens.of(context).screenPaddingHorizontal] property.
  Widget withScreenPaddingHorizontal(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.of(context).paddingScreenHorizontal,
      ),
      child: this,
    );
  }

  /// Wraps the widget with screen padding vertical.
  /// The padding value is taken from the [Dimens.of(context).screenPaddingVertical] property.
  Widget withScreenPaddingVertical(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimens.of(context).paddingScreenVertical,
      ),
      child: this,
    );
  }
}

extension WidgetListExtensionX on List<Widget> {
  Widget toRow() {
    return Row(mainAxisSize: MainAxisSize.min, children: this);
  }

  Widget toColumn() {
    return Column(mainAxisSize: MainAxisSize.min, children: this);
  }

  Widget toWrap() {
    return Wrap(spacing: 10, runSpacing: 10, children: this);
  }

  List<Widget> separatedBy(Widget seperator) {
    return List.generate(length * 2 - 1, (index) {
      if (index.isEven) {
        return this[index ~/ 2];
      } else {
        return seperator;
      }
    });
  }
}
