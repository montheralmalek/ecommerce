import 'package:flutter/material.dart';
import 'package:store/presentation/views/home/home_screen.dart';

// List<GetPage<dynamic>> pagesRoutes = [
//   //--------------------- Auth Pages ---------------------
//   // GetPage(
//   //     name: '/',
//   //     page: () => const LoginScreen(),
//   //     middlewares: [AppMiddleware()]),

//   //--------------------- Home Page ---------------------
//   GetPage(name: MyHomePage.id, page: () => const MyHomePage()),
// ];
Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.id: (context) => const HomeScreen(),
};
