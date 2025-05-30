import 'package:flutter/material.dart';

extension WidgetExtensionX on Widget {
  Widget get toSliver {
    return SliverToBoxAdapter(child: this);
  }

  Widget withMaterial(bool condition) {
    if (condition) {
      return Material(type: MaterialType.transparency, child: this);
    }
    return this;
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
