import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/core/utils/themes/app_theme.dart';

import 'pages_routes.dart';

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialBinding: AppBindings(),
      getPages: pagesRoutes,
      theme: AppTheme.lightTheme(Get.locale),
      darkTheme: AppTheme.darkTheme(Get.locale),
    );
  }
}
