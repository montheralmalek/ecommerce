import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:store/core/utils/extensions/context_extensions.dart';
import 'package:store/development_view.dart';
import 'package:store/domain/entities/product.dart';
import 'package:store/ui/features/cart/views/add_to_cart_view.dart';
import 'package:store/ui/features/home/views/home_screen.dart';
import 'package:store/ui/features/product/views/product_detail_screen.dart';
import 'package:store/ui/features/product/views/product_feedback_screen.dart';
import 'package:store/ui/features/settings/widgets/settings_screen.dart';
import 'package:store/core/widgets/widgets.dart';

import '../ui/features/auth/widgets/login_screen.dart';
import 'routes.dart';

final _log = Logger('Router');
final GoRouter router = GoRouter(
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
      builder: (context, state) {
        _log.info('Navigating to Home Screen');
        return const HomeScreen();
      },
      // pageBuilder: (context, state) {
      //   return platformPage(context: context, child: const HomeScreen());
      // },
    ),
    GoRoute(
      name: AppRoutes.login,
      path: AppRoutes.login,
      builder: (context, state) {
        _log.info('Navigating to Login Screen');
        return const LoginScreen();
      },
      // pageBuilder: (context, state) {
      //   return platformPage(context: context, child: const LoginScreen());
      // },
    ),
    GoRoute(
      name: AppRoutes.productDetails,
      path: '${AppRoutes.productDetails}/:id',
      builder: (context, state) {
        _log.info(
          'Navigating to Product Detail Screen with id: ${state.pathParameters['id']}',
        );

        final id = int.parse(state.pathParameters['id'] ?? '0');
        return ProductDetailScreen(productId: id);
      },
      // pageBuilder: (context, state) {
      //   // final product = state.extra as Product;
      //   // final id = product.id;
      //   final id = int.parse(state.pathParameters['id']!);
      //   return platformPage(
      //     context: context,
      //     child: ProductDetailScreen(productId: id),
      //   );
      // },
    ),

    GoRoute(
      name: AppRoutes.settings,
      path: AppRoutes.settings,
      builder: (context, state) {
        _log.info('Navigating to Settings Screen');
        return const SettingsScreen();
      },
      // pageBuilder: (context, state) {
      //   return platformPage(context: context, child: const SettingsScreen());
      // },
    ),
    GoRoute(
      name: AppRoutes.about,
      path: AppRoutes.about,
      builder: (context, state) {
        _log.info('Navigating to About Screen');
        return const UnImplementedWidget();
      },
      // pageBuilder: (context, state) {
      //   return platformPage(
      //     context: context,
      //     child: UnImplementedWidget(key: const Key('about_screen')),
      //   );
      // },
    ),
    GoRoute(
      name: AppRoutes.productRating,
      path: AppRoutes.productRating,
      // builder: (context, state) {
      //   _log.info('Navigating to Product Rating Screen');
      //   return const ProductRatingView();
      // },
      pageBuilder: (context, state) {
        return platformPage(
          context: context,
          child: const ProductFeedbackScreen(),
        );
      },
    ),
    // Cart Routes----------
    GoRoute(
      name: AppRoutes.addToCart,
      path: AppRoutes.addToCart,

      builder: (context, state) {
        _log.info('Navigating to Add to Cart Screen');
        final Product product = state.extra as Product;
        return AddToCartView(productId: product.id);
      },
    ),
    // Development View Route (only in debug mode)
    if (const bool.fromEnvironment('dart.vm.product') == false)
      GoRoute(
        name: AppRoutes.developmentView,
        path: AppRoutes.developmentView,
        builder: (context, state) {
          _log.info('Navigating to Development View');
          return const DevelopmentView();
        },
      ),
  ],
);

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
