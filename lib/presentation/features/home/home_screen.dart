import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/presentation/features/home/log_out_button.dart';
import 'package:store/core/utils/extensions/widget_extensions.dart';
import 'package:store/domain/domain_models/banner.dart';
import 'package:store/domain/domain_models/section.dart';
import 'package:store/presentation/features/home/cubits/homeScreenCubit/home_cubit.dart';
import 'package:store/presentation/features/home/home_section_widget.dart';
import 'package:store/routing/routes.dart';
import 'package:store/widgets/custom_error_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';
  const HomeScreen({super.key});

  static final _log = Logger('HomeScreen');
  @override
  Widget build(BuildContext context) {
    _log.info('HomeScreen build (${context.platform.name})');
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Home'),
        trailingActions: _appBarActionsList,
        // leading: _homeDrawerButton(context),
      ),
      material:
          (context, platform) => MaterialScaffoldData(
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Text(
                        'Welcome to Home',
                        style: context.textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  // NavigationDrawer(children: children)
                  ListTile(
                    title: Text('Settings'),
                    onTap: () {
                      // Close the drawer first
                      Navigator.of(context).pop();

                      context.push(AppRoutes.settings);
                    },
                  ),
                  ListTile(
                    title: Text('About'),
                    onTap: () {
                      // context.pushNamed(AppRoutes.about);
                    },
                  ),
                ],
              ),
            ),
          ),

      body: const BuildHomeSections(),
    );
  }

  List<Widget> get _appBarActionsList => [
    const LogOutButton(),
    const RefreshHomeButton(),
  ];
}

class BuildHomeSections extends StatelessWidget {
  const BuildHomeSections({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeError) {
          return CustomErrorWidget(message: state.message);
        }

        final List<Section> sections = state.sections;

        return SafeArea(
          child: CustomScrollView(
            physics: PageScrollPhysics(),
            slivers: [
              // BannerSlider(isLoading: state is HomeLoading).toSliver,
              ...sections.map((e) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  sliver:
                      HomeSectionWidget(
                        isLoading: state is HomeLoading,
                        section: e,
                        title: e.title,
                      ).toSliver,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.bannerModel,
    this.width = double.infinity,
    this.height = 200,
    this.backgroundColor,
    this.isLoading = false,
  });
  final BannerModel bannerModel;
  final double? height, width;
  final Color? backgroundColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        // child: Center(child: Text(bannerModel.title, style: TextStyle(fontSize: 30))),
      ),
    );
  }
}

/// Refresh button

class RefreshHomeButton extends StatelessWidget {
  const RefreshHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const SizedBox();
        }
        return _buildRefreshButton(context);
      },
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return PlatformIconButton(
      icon: Icon(context.platformIcons.refresh),
      onPressed: () {
        // context.push(AppRoutes.about);
        BlocProvider.of<HomeCubit>(context).retry();
      },
    );
  }
}

class SwitchThemeMode extends StatelessWidget {
  const SwitchThemeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      thumbColor: WidgetStateColor.fromMap({
        WidgetState.any: context.colorScheme.onSecondary,
      }),
      trackOutlineWidth: WidgetStateMapper({WidgetState.any: 0}),
      trackColor: WidgetStateMapper({
        WidgetState.any: context.colorScheme.secondary,
      }),
      thumbIcon: WidgetStateMapper({
        WidgetState.selected: Icon(
          Icons.light_mode,
          color: context.colorScheme.secondary,
        ),
        WidgetState.any: Icon(
          Icons.dark_mode,
          color: context.colorScheme.secondary,
        ),
      }),

      value: PlatformTheme.of(context)?.isDark ?? false,
      onChanged: (value) {
        PlatformTheme.of(context)?.themeMode =
            value ? ThemeMode.dark : ThemeMode.light;
      },
    );
  }
}
