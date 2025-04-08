import 'package:permission_handler/permission_handler.dart';

class HelperFunctions {
  static Future<void> checkPermission(Permission permission) async {
    final status = await permission.status;
    if (!status.isGranted) {
      await permission.request();
    }
  }
}
