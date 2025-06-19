import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/presentation/features/settings/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: const Text('Settings')),

      body: ListView(
        children: [
          BlocBuilder<SettingCubit, SettingState>(
            builder: (context, state) {
              return ExpandableDropdown(
                title: const Text('Theme Mode'),
                subtitle: Text(
                  context.read<SettingCubit>().state.themeMode.name,
                ),
                leading: Icon(
                  context.platformIcon(
                    material: Icons.mode,
                    cupertino: CupertinoIcons.sparkles,
                  ),
                ),
                children:
                    ThemeMode.values.map((mode) {
                      return RadioListTile.adaptive(
                        useCupertinoCheckmarkStyle: true,
                        activeColor: context.colorScheme.primary,
                        dense: true,
                        value: mode,
                        groupValue: state.themeMode,
                        selected: mode == state.themeMode,
                        onChanged: (value) async {
                          if (value != null) {
                            await context.read<SettingCubit>().setThemeMode(
                              value,
                            );
                          }
                        },
                        title: Text(
                          mode.toString().split('.').last,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
              );
            },
          ),

          PlatformListTile(
            title: const Text('Notifications'),
            leading: Icon(Icons.notifications_outlined),
            trailing: Switch.adaptive(
              thumbColor: WidgetStateColor.fromMap({
                WidgetState.any: context.colorScheme.onSecondary,
              }),
              trackOutlineWidth: WidgetStateMapper({WidgetState.any: 0}),
              trackColor: WidgetStateMapper({
                WidgetState.any: context.colorScheme.secondary,
              }),
              thumbIcon: WidgetStateMapper({
                WidgetState.selected: Icon(
                  Icons.notifications_on,
                  color: context.colorScheme.secondary,
                ),
                WidgetState.any: Icon(
                  Icons.notifications_off,
                  color: context.colorScheme.secondary,
                ),
              }),
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
}

class ExpandableDropdown extends StatefulWidget {
  final Widget? header;
  final List<Widget> children;
  final Duration duration;
  final Curve curve;
  final bool initiallyExpanded;
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;

  const ExpandableDropdown({
    super.key,
    this.header,
    this.title,
    this.subtitle,
    this.leading,
    required this.children,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.initiallyExpanded = false,
  }) : assert(
         header != null || title != null,
         'Either header or title must not be null',
       );

  @override
  State<ExpandableDropdown> createState() => _ExpandableDropdownState();
}

class _ExpandableDropdownState extends State<ExpandableDropdown>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _sizeAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);
    if (_expanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context),
        // if (_expanded) Divider(),
        SizeTransition(
          sizeFactor: _sizeAnimation,
          axisAlignment: -1.0,
          child: Card(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7),
              ),
              borderSide: BorderSide(
                color: context.theme.splashColor,
                width: 0.6,
              ),
            ),
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return widget.header != null
        ? GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggle,
          child: widget.header,
        )
        : Platform.isIOS || Platform.isMacOS
        ? CupertinoListTile(
          title: widget.title!,
          subtitle: widget.subtitle,
          leading: widget.leading,
          trailing: _getTrailing(context),
          onTap: _toggle,
        )
        : ListTile(
          title: widget.title,
          subtitle: widget.subtitle,
          leading: widget.leading,
          trailing: _getTrailing(context),
          onTap: _toggle,
        );
  }

  Widget _getTrailing(BuildContext context) {
    final iconData =
        _expanded
            ? CupertinoIcons.chevron_down
            : CupertinoIcons.chevron_forward;

    return Icon(iconData, color: context.colorScheme.onSurface);
  }
}
