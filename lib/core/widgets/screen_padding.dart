import 'package:flutter/widgets.dart';
import 'package:store/core/themes/dimens.dart';

class ScreenPaddind extends StatelessWidget {
  const ScreenPaddind({
    super.key,
    this.horizontal = true,
    this.vertical = true,
    this.child,
  });
  const ScreenPaddind.horizontal({super.key, this.child})
    : horizontal = true,
      vertical = false;
  const ScreenPaddind.vertical({super.key, this.child})
    : horizontal = false,
      vertical = true;

  final bool horizontal;
  final bool vertical;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ? Dimens.of(context).paddingScreenHorizontal : 0,
        vertical: vertical ? Dimens.of(context).paddingScreenHorizontal : 0,
      ),
      child: child,
    );
  }
}
