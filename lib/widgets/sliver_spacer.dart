import 'package:flutter/material.dart';

class SliverSpacer extends StatelessWidget {
  // const SliverSpacer._({
  //   super.key,
  // });
  const SliverSpacer.vertical(this.verticalSpace, {super.key})
    : horizontalSpace = 0;
  const SliverSpacer.horizontal(this.horizontalSpace, {super.key})
    : verticalSpace = 0;
  final double verticalSpace;
  final double horizontalSpace;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: verticalSpace, width: horizontalSpace),
    );
  }
}
