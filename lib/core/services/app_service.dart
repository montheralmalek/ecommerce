import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<AppService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}

initialServices() async {
  try {
    await Get.putAsync(() => AppService().init());
    // final dbService = await Get.putAsync(() => DatabaseService().init());
    // final database = DatabaseInitializer();
    // final db = await dbService.database;
  } on Exception catch (e) {
    debugPrint('--------------------- Error initializing services: $e');
  }
}
