import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/styles/color.dart';

class IconGallery extends StatelessWidget {
  final int? icon;
  final dynamic image;
  final bool disabled;
  final Function()? onPressed;
  final Size? buttonSize;
  final double? iconSize;
  final Color borderColor;
  final Color iconColor;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;

  const IconGallery({
    Key? key,
    this.icon,
    this.onPressed,
    this.disabled = false,
    this.buttonSize = const Size(200, 200),
    this.iconSize,
    this.borderColor = kPrimaryLightColor,
    this.iconColor = kPrimaryLightColor,
    this.image,
    this.borderWidth = 5,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onPressed = disabled ? null : this.onPressed;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(1000)),
      child: ElevatedButton(
          onPressed: onPressed,
          onLongPress: null,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            primary: disabled ? Colors.black45 : iconColor,
            shape: const CircleBorder(),
            fixedSize: buttonSize,
            elevation: 0,
          ),
          child: _iconPicker()),
    );
  }

  Widget _iconPicker() {
    if (image == null && icon != null && iconSize != null) {
      return Icon(
        IconData(icon!, fontFamily: "MaterialIcons"),
        color: textIcons,
        size: iconSize!
      );
    } else if (image is Uint8List) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(fit: BoxFit.fill, image: MemoryImage(image)),
          borderRadius: const BorderRadius.all(Radius.circular(1000)),
          color: kPrimaryLightColor,
        ),
      );
    } else if (image is String) {
      return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryLightColor,
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            placeholder: (context, url) => Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryLightColor,
                ),
              ),
            ),
            imageUrl: image as String,
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(fit: BoxFit.fill, image: FileImage(image!)),
          color: kPrimaryLightColor,
        ),
      );
    }
  }
}
