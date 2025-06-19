import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:store/core/themes/app_theme.dart';
import 'package:store/core/utils/extensions/theme_mode_extensions.dart';
import 'package:store/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:store/routing/router.dart';

class MainPlatformApp extends StatelessWidget {
  const MainPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      settings: PlatformSettingsData(
        legacyIosUsesMaterialWidgets: true,
        iosUsesMaterialWidgets: true,
      ),
      builder: (context) {
        return BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            return PlatformApp.router(
              title: 'Store App',
              routerConfig: router,
              debugShowCheckedModeBanner: kDebugMode ? true : false,
              localizationsDelegates: [
                DefaultCupertinoLocalizations.delegate,
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'ar'), // add other locales if needed
              ],

              material:
                  (_, _) => MaterialAppRouterData(
                    themeMode: state.themeMode,
                    theme:
                        state.themeMode.isDark
                            ? AppTheme.materialDarkTheme
                            : AppTheme.materialLightTheme,
                    darkTheme: AppTheme.materialDarkTheme,
                  ),
              cupertino:
                  (context, platform) => CupertinoAppRouterData(
                    theme:
                        state.themeMode.isDark
                            ? AppTheme.cupertinoDarkTheme
                            : AppTheme.cupertinoLightTheme,
                  ),
            );
          },
        );
      },
    );
  }
}
