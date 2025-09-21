import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:store/core/widgets/input_quantity.dart';
import 'package:store/core/widgets/widgets.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/widgets/default_cupertino_navigation_bar_data.dart';

class DevelopmentView extends StatelessWidget {
  const DevelopmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Development View'),
        cupertino:
            (context, platform) => defaultCupertinoNavigationBarData(context),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton.outLined(label: ' label', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// Development view button
class GoToDevelopmentViewButton extends StatelessWidget {
  const GoToDevelopmentViewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      padding: EdgeInsets.zero,
      icon: Icon(context.platformIcons.info),
      onPressed: () {
        context.push(AppRoutes.developmentView);
      },
    );
  }
}
