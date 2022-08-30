import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hawker_geo/core/model/hawker_category_enum.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:latlong2/latlong.dart';

import '../../core/model/gender_enum.dart';
import '../../core/model/role_enum.dart';
import '../../core/model/user.dart';
import '../persistence/firestore/user_repo.dart';

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
            kPrimaryColor,
            kSecondColor,
          ],
          stops: [startGradient, endGradient],
        ).createShader(rect);
      },
    );
  }

  generateHawker(int quantity) {
    for (int i = 0; i < quantity; i++) {
      var category =
          HawkerCategoryEnum.values.elementAt(Random().nextInt(HawkerCategoryEnum.values.length));
      debugPrint("Vendedor $i | Categoria: ${category.value}");
      UserRepo().saveOrUpdate(User(
          active: true,
          status: StatusEnum.A,
          email: "hawker_$i@email.com",
          gender: GenderEnum.O,
          name: "Vendedor $i",
          password: "Teste123879*5454545mn",
          phoneNumber: "44999999999",
          role: RoleEnum.ROLE_HAWKER,
          urlPhoto: "",
          username: "hawker$i",
          hawkerCategory: category,
          position: LatLng(-23.07993 + i / 1000, -52.46181 + i / 1000)));
    }
  }
}
