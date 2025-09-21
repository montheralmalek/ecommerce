import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/development_view.dart';
import 'package:store/ui/features/home/views/keep_alive.dart';
import 'package:store/ui/features/home/widgets/log_out_button.dart';
import 'package:store/domain/entities/home_section.dart';
import 'package:store/ui/features/home/cubits/get_home_sections_cubit/home_sections_cubit.dart';
import 'package:store/ui/features/home/widgets/home_section_item.dart';
import 'package:store/routing/routes.dart';
import 'package:store/core/widgets/custom_error_widget.dart';
import 'package:store/ui/widgets/default_cupertino_navigation_bar_data.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';
  const HomeScreen({super.key});

  static final _log = Logger('HomeScreen');

  @override
  Widget build(BuildContext context) {
    _log.info('HomeScreen build (${context.platform.name})');
    return PlatformScaffold(
      appBar: _buildPlatformAppBar(context),

      material: _getMaterialScaffoldDatat,
      cupertino: _getCapertinoPageScaffoldDatat,

      body: _getHomePageBody(context),
    );
  }

  // AppBar
  PlatformAppBar _buildPlatformAppBar(BuildContext context) {
    return PlatformAppBar(
      title: _getAppBarTitle(),
      trailingActions: _appBarActionsList,
      leading: _homeDrawerButton(context),
      cupertino:
          (context, platform) => defaultCupertinoNavigationBarData(context),
    );
  }

  Widget _getAppBarTitle() => PlatformText('Store Name');

  //
  MaterialScaffoldData _getMaterialScaffoldDatat(context, platform) {
    return MaterialScaffoldData(drawer: _buildMaterialDrawer(context));
  }

  //
  CupertinoPageScaffoldData _getCapertinoPageScaffoldDatat(context, platform) {
    return CupertinoPageScaffoldData(
      // navigationBar: CupertinoNavigationBar()
    );
  }

  // Body building function
  Widget _getHomePageBody(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeSectionState>(
      builder: (context, state) {
        if (state is HomeSectionError) return _buildError(state);
        if (state is HomeSectionInitial) {
          context.read<HomeCubit>().loadHomeSections();
        }
        if (state is HomeSectionLoading) return _buildLoading();
        if (state is HomeSectionLoaded) return _buildSections(state.sections);
        return const SizedBox.shrink();
      },
    );
  }

  //---------
  Widget _buildSections(List<HomeSection> sections) {
    return SafeArea(
      child: CustomScrollView(
        physics: PageScrollPhysics(),
        slivers: [
          SliverList.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              return KeepAliveWrapper(child: HomeSectionItem(section: section));
              // return _HomeSectionItem(
              //   // Extract to StatefulWidget
              //   key: Key('${section.targetId}_${section.type.name}'),
              //   section: section,
              // );
            },
          ),
        ],
      ),
    );
  }

  //
  Widget _buildLoading() => Center(child: CircularProgressIndicator());
  //
  Widget _buildError(HomeSectionError state) =>
      CustomErrorWidget(message: state.message);
  //
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

  Widget? _homeDrawerButton(BuildContext context) {
    if (isCupertino(context)) {
      return PlatformIconButton(
        icon: Icon(CupertinoIcons.line_horizontal_3),
        onPressed: () {
          _openNavigation(context);
        },
      );
    }
    return null;
  }

  List<Widget> get _appBarActionsList => [
    const LogOutButton(),
    const RefreshHomeButton(),
    if (kDebugMode) const GoToDevelopmentViewButton(),
  ];
}

/// Refresh button

class RefreshHomeButton extends StatelessWidget {
  const RefreshHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeSectionState>(
      builder: (context, state) {
        if (state is HomeSectionLoading) {
          return const SizedBox.shrink();
        }
        return _buildRefreshButton(context);
      },
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return PlatformIconButton(
      padding: EdgeInsets.zero,
      icon: Icon(context.platformIcons.refresh),
      onPressed: () {
        context.read<HomeCubit>().retry();
        // BlocProvider.of<HomeCubit>(context).retry();
      },
    );
  }
}
