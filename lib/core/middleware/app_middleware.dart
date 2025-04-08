// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:seller/core/utils/constants/app_roots.dart';
// import 'package:seller/core/services/app_service.dart';

// class AppMiddleware extends GetMiddleware {
//   AppService appService = Get.find();
//   @override
//   int? get priority => 1;
//   @override
//   RouteSettings? redirect(String? route) {
//     var token = appService.sharedPreferences.getString('token');
//     if (token != null && token.isNotEmpty) {
//       return const RouteSettings(name: AppRoots.clientHome);
//     }
//     return super.redirect(route);
//   }
// }
