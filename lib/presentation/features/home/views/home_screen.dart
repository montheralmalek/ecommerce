import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/core/themes/dimens.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/presentation/features/home/widgets/log_out_button.dart';
import 'package:store/core/utils/extensions/widget_extensions.dart';
import 'package:store/domain/domain_models/banner.dart';
import 'package:store/domain/domain_models/section.dart';
import 'package:store/presentation/features/home/cubits/homeScreenCubit/home_cubit.dart';
import 'package:store/presentation/features/home/widgets/home_section_widget.dart';
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
          (context, platform) =>
              MaterialScaffoldData(drawer: _buildMaterialDrawer(context)),
      cupertino:
          (context, platform) => CupertinoPageScaffoldData(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Home'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: _appBarActionsList,
              ),
              leading: _homeDrawerButton(context),
            ),
          ),

      body: const BuildHomeSections(),
    );
  }

  void _openNavigation(BuildContext context) {
    if (isMaterial(context)) {
      Scaffold.of(context).openDrawer();
    } else {
      _showCupertinoMenu(context);
    }
  }

  Widget _buildMaterialDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Welcome to Home',
                style: context.textTheme.headlineMedium,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
              context.push(AppRoutes.settings);
            },
          ),
        ],
      ),
    );
  }

  void _showCupertinoMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (context) => CupertinoActionSheet(
            title: const Text('Menu'),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  context.pop();
                  // Navigate to settings
                  context.push(AppRoutes.settings);
                },
                child: const Text('Settings'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ),
    );
  }

  Widget _homeDrawerButton(BuildContext context) {
    return PlatformIconButton(
      icon: Icon(CupertinoIcons.line_horizontal_3),
      onPressed: () {
        _openNavigation(context);
      },
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

        final List<HomeSectionI> homeSections = state.sections;

        return SafeArea(
          child: CustomScrollView(
            physics: PageScrollPhysics(),
            slivers: [
              // BannerSlider(isLoading: state is HomeLoading).toSliver,
              ...homeSections.map((section) {
                return HomeSectionWidget(
                  isLoading: state is HomeLoading,
                  homeSection: section,
                  title: section.title,
                ).toSliver;
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
        BlocProvider.of<HomeCubit>(context).retry();
      },
    );
  }
}
