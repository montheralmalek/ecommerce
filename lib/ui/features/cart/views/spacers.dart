import 'package:flutter/material.dart';
import 'package:store/core/themes/dimens.dart';

class Spacers extends StatelessWidget {
  const Spacers._(this.space, this.direction, {super.key});

  factory Spacers.verticalSmall({Key? key}) =>
      Spacers._(Dimens.p12, Axis.vertical, key: key);
  factory Spacers.verticalMedium({Key? key}) =>
      Spacers._(Dimens.p20, Axis.vertical, key: key);
  factory Spacers.verticalLarge({Key? key}) =>
      Spacers._(Dimens.p32, Axis.vertical, key: key);
  factory Spacers.horizontalSmall({Key? key}) =>
      Spacers._(Dimens.p12, Axis.horizontal, key: key);
  factory Spacers.horizontalMedium({Key? key}) =>
      Spacers._(Dimens.p20, Axis.horizontal, key: key);
  factory Spacers.horizontalLarge({Key? key}) =>
      Spacers._(Dimens.p32, Axis.horizontal, key: key);

  final double space;
  final Axis direction;
  @override
  Widget build(BuildContext context) {
    return direction == Axis.horizontal
        ? SizedBox(height: space)
        : SizedBox(width: space);
  }
}
