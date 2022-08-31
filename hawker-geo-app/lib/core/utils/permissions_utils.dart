import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsUtils {
  static Future<bool> checkPermissionCamera() async {
    final status = await Permission.camera.request();

    if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
        msg:
            "Não foi possível perguntar por permissão ou a permissão foi negada mas não permanentemente.",
      );
      return false;
    } else if (status == PermissionStatus.restricted) {
      Fluttertoast.showToast(msg: "O sistema restringiu o acesso");
      return false;
    }

    return status == PermissionStatus.granted ? true : false;
  }

  static Future<bool> checkPermissionPhoto() async {
    final status = await Permission.photos.request();

    if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 2000,
          msg:
              "Não foi possível perguntar por permissão ou a permissão foi negada mas não permanentemente.");
      return false;
    } else if (status == PermissionStatus.restricted) {
      Fluttertoast.showToast(msg: "O sistema restringiu o acesso");
      return false;
    }
    return status == PermissionStatus.granted ? true : false;
  }
}
