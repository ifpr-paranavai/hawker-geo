import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hawker_geo/core/model/hawker_category_enum.dart';
import 'package:hawker_geo/core/model/hawker_details.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:hawker_geo/core/utils/app_images.dart';
import 'package:hawker_geo/core/utils/permissions_utils.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../core/model/gender_enum.dart';
import '../../core/model/role_enum.dart';
import '../../core/model/user.dart';
import '../persistence/firestore/user_repository.dart';

class Util {
  gradientIcon(double size, IconData icon, {double startGradient = 0, double endGradient = 0.55}) {
    return ShaderMask(
      child: SizedBox(
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
            kPrimaryLightColor,
            kSecondLightColor,
          ],
          stops: [startGradient, endGradient],
        ).createShader(rect);
      },
    );
  }

  generateHawker(int quantity) async {
    ByteData bytes = await rootBundle.load(AppImages.foodPlaceholder);
    var buffer = bytes.buffer;
    var base64Photo = base64Encode(Uint8List.view(buffer));
    for (int i = 0; i < quantity; i++) {
      var category =
          HawkerCategoryEnum.values.elementAt(Random().nextInt(HawkerCategoryEnum.values.length));
      debugPrint("Vendedor $i | Categoria: ${category.value}");
      UserRepository().saveOrUpdate(User(
          active: true,
          status: StatusEnum.A,
          email: "hawker_$i@email.com",
          gender: GenderEnum.O,
          name: "Vendedor $i",
          password: "Teste123879*5454545mn",
          phoneNumber: "44999999999",
          role: RoleEnum.ROLE_HAWKER,
          urlPhoto: "",
          base64Photo: base64Photo,
          username: "hawker$i",
          position: LatLng(-23.07993 + i / 1000, -52.46181 + i / 1000),
          hawkerDetails: HawkerDetails(
              companyName: "Vendedor $i",
              cpf: "005522552",
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...",
              categories: <HawkerCategoryEnum>[category],
              averageRating: 3)));
    }
  }

  void getImageFromCameraOrGallery(ImageSource source, Function(XFile image) func) async {
    bool permissionAccepted = false;
    if (source == ImageSource.camera) {
      permissionAccepted = await PermissionsUtils.checkPermissionCamera();
    } else if (source == ImageSource.gallery) {
      permissionAccepted = await PermissionsUtils.checkPermissionPhoto();
    }
    if (permissionAccepted) {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        func(image);
      }
    }
  }
}
