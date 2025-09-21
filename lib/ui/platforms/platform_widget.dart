import 'package:flutter/widgets.dart';

import 'platform.dart';
import 'widget_base.dart';

class PlatformWidget extends PlatformWidgetBase<Widget, Widget> {
  final PlatformBuilder<Widget?>? material;
  final PlatformBuilder<Widget?>? cupertino;

  const PlatformWidget({super.key, this.cupertino, this.material});

  @override
  Widget createMaterialWidget(BuildContext context) {
    return material?.call(context, platform(context)) ??
        const SizedBox.shrink();
  }

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return cupertino?.call(context, platform(context)) ??
        const SizedBox.shrink();
  }
}
