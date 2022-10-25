/*
 * Created by Kairo Amorim on 31/08/2022 13:06
 * Copyright (c) 2022. All rights reserved.
 * Last modified 31/08/2022 13:06
 */

import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/register/screen/components/icon_galery.dart';
import 'package:hawker_geo/ui/styles/color.dart';

class EditPhotoWidget extends StatelessWidget {
  final dynamic image;
  final Color color;
  final VoidCallback? onPressed;

  const EditPhotoWidget(
      {Key? key, required this.image, this.color = kPrimaryLightColor, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, fit: StackFit.loose, children: [
      Align(
        alignment: Alignment.center,
        child: IconGallery(
          borderColor: color,
          iconColor: color,
          borderWidth: 3,
          padding: const EdgeInsets.all(6),
          disabled: false,
          icon: Icons.account_circle_sharp.codePoint,
          image: image,
          onPressed: onPressed,
          buttonSize: const Size(90, 90),
          iconSize: 70,
        ),
      ),
      Positioned(
        right: 105,
        bottom: -3,
        child: Transform.scale(
          scale: 0.85,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: color,
              shape: const CircleBorder(),
            ),
            child: const Icon(
              Icons.edit,
              size: 20,
            ),
          ),
        ),
      )
    ]);
  }
}
