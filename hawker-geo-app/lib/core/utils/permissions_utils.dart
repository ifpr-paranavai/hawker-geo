import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsUtils {
  static Future<bool> checkPermissionCamera() async {
    final status = await Permission.camera.request();

    if ( status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied ) {
      Fluttertoast.showToast(
          msg:
              "We didn't ask for permission yet or the permission has been denied before but not permanently.",
      );
      return false;
    } else if (status == PermissionStatus.restricted) {
      Fluttertoast.showToast(msg: "The OS restricts access");
      return false;
    }

    return status == PermissionStatus.granted ? true : false;
  }

  static Future<bool> checkPermissionPhoto() async {
    final status = await Permission.photos.request();

    if ( status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied ) {
      Fluttertoast.showToast(
        timeInSecForIosWeb: 2000,
          msg:
              "We didn't ask for permission yet or the permission has been denied before but not permanently.");
      return false;
    } else if (status == PermissionStatus.restricted) {
      Fluttertoast.showToast(msg: "The OS restricts access");
      return false;
    }
    return status == PermissionStatus.granted ? true : false;
  }
}
