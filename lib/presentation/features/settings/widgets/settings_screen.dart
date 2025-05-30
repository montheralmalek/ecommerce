import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: const Text('Settings')),

      body: ListView(
        children: [
          ListTile(
            title: Text('Theme Mode'),
            leading: _buildModeIconButton(context),
            onTap: () {
              // Toggle theme mode
              // context.toggleThemeMode();
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(context.locale.toString()),
            onTap: () {
              // Change language
              // context.changeLocale();
            },
          ),
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch.adaptive(
              value: true,
              onChanged: (value) {
                // context.toggleNotifications(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  PlatformIconButton _buildModeIconButton(BuildContext context) {
    final isDark = PlatformTheme.of(context)?.isDark ?? false;
    final icon =
        isDark
            ? Icon(
              context.platformIcon(
                cupertino: CupertinoIcons.sun_max_fill,
                material: Icons.light_mode,
              ),
            )
            : Icon(
              context.platformIcon(
                cupertino: CupertinoIcons.moon_fill,
                material: Icons.dark_mode,
              ),
            );
    return PlatformIconButton(
      icon: icon,
      onPressed: () {
        PlatformTheme.of(context)?.themeMode =
            isDark ? ThemeMode.light : ThemeMode.dark;
      },
    );
  }
}
