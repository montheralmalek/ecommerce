import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/shared/providers.dart';
import 'package:store/presentation/views/home/home_screen.dart';
import 'pages_routes.dart';

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: HomeScreen.id,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),

      // theme: AppTheme.lightTheme(Get.locale),
      // darkTheme: AppTheme.darkTheme(Get.locale),
      // home: const HomeView(),
    );
  }
}
