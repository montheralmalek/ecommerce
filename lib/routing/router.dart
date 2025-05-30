import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:store/core/config/dependency_injection.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/data/repositories/auth_repository.dart';
import 'package:store/presentation/features/home/home_screen.dart';
import 'package:store/presentation/features/product_detail/widgets/product_detail_screen.dart';
import 'package:store/presentation/features/settings/widgets/settings_screen.dart';
import 'package:store/widgets/widgets.dart';

import '../presentation/features/auth/widgets/login_screen.dart';
import 'routes.dart';

final _log = Logger('Router');
GoRouter router([AuthRepository? authRepository]) {
  _log.info('Start router initialization');
  authRepository ??= getIt<AuthRepository>();
  return GoRouter(
    initialLocation: AppRoutes.initial,
    debugLogDiagnostics: true,

    // redirect: (context, state) async {
    //   // if the user is not logged in, they need to login
    //   final loggedIn = await authRepository.isAuthenticated;
    //   final loggingIn = state.matchedLocation == AppRoutes.login;
    //   if (!loggedIn) {
    //     log.info(
    //       'Redirecting from ${state.matchedLocation} to ${AppRoutes.login}',
    //     );
    //     return AppRoutes.login;
    //   }

    //   // if the user is logged in but still on the login page, send them to
    //   // the home page
    //   if (loggingIn) {
    //     log.info(
    //       'Redirecting from ${state.matchedLocation} to ${AppRoutes.home}',
    //     );
    //     return AppRoutes.home;
    //   }

    //   // no need to redirect at all
    //   return null;
    // },
    errorPageBuilder: _errorPage,

    routes: [
      GoRoute(
        name: AppRoutes.home,
        path: AppRoutes.home,
        pageBuilder: (context, state) {
          return platformPage(context: context, child: const HomeScreen());
        },
      ),
      GoRoute(
        name: AppRoutes.login,
        path: AppRoutes.login,
        pageBuilder: (context, state) {
          return platformPage(context: context, child: const LoginScreen());
        },
      ),
      GoRoute(
        name: AppRoutes.productDetails,
        path: '${AppRoutes.productDetails}/:id',

        pageBuilder: (context, state) {
          // final product = state.extra as Product;
          // final id = product.id;
          final id = int.parse(state.pathParameters['id']!);
          return platformPage(
            context: context,
            child: ProductDetailScreen(productId: id),
          );
        },
      ),

      GoRoute(
        name: AppRoutes.settings,
        path: AppRoutes.settings,
        pageBuilder: (context, state) {
          return platformPage(context: context, child: const SettingsScreen());
        },
      ),
      GoRoute(
        name: AppRoutes.about,
        path: AppRoutes.about,
        pageBuilder: (context, state) {
          return platformPage(
            context: context,
            child: UnImplementedWidget(key: const Key('about_screen')),
          );
        },
      ),
    ],
  );
}

Page _errorPage(BuildContext context, GoRouterState state) {
  _log.severe('Error: ${state.error}');

  return platformPage(
    context: context,
    child: ErrorScreen(
      message:
          state.error != null
              ? 'Page Not Found: ${state.error}'
              : 'Unknown Route',
    ),
  );
}

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, this.message = 'Page Not Found'});
  static final _log = Logger('ErrorScreen');

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(body: CustomErrorWidget(message: message));
  }
}

class UnImplementedWidget extends StatelessWidget {
  const UnImplementedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: Text(
          'This feature is not implemented yet.\n'
          'Please check back later.',
          textAlign: TextAlign.center,
          style: context.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
// // From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
// Future<String?> _redirect(BuildContext context, GoRouterState state) async {
//   // if the user is not logged in, they need to login
//   final loggedIn = await context.read<AuthRepository>().isAuthenticated;
//   final loggingIn = state.matchedLocation == Routes.login;
//   if (!loggedIn) {
//     return Routes.login;
//   }

//   // if the user is logged in but still on the login page, send them to
//   // the home page
//   if (loggingIn) {
//     return Routes.home;
//   }

//   // no need to redirect at all
//   return null;
// }
