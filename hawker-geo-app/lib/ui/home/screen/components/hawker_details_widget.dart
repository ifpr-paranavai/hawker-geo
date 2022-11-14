/*
 * Created by Kairo Amorim on 31/08/2022 22:47
 * Copyright© 2022. All rights reserved.
 * Last modified 31/08/2022 22:47
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawker_geo/core/model/hawker_category_enum.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/core/utils/app_images.dart';
import 'package:hawker_geo/ui/shared/custom-behavior.dart';
import 'package:hawker_geo/ui/shared/gradient_icon.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:hawker_geo/ui/styles/text.dart';

class HawkerDetailsWidget extends StatelessWidget {
  final User hawker;
  final VoidCallback? callButtonOnPressed;

  const HawkerDetailsWidget({Key? key, required this.hawker, this.callButtonOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 150,
                  height: 10,
                  decoration:
                      BoxDecoration(color: dividerColor, borderRadius: BorderRadius.circular(80)),
                ),
              ),
            ],
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: CustomBehavior(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              radius: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(base64Decode(hawker.base64Photo!))),
                                  borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                  color: kPrimaryLightColor,
                                ),
                              )),
                          Text(hawker.name!, style: boldTitle),
                          IconButton(
                              onPressed: callButtonOnPressed,
                              icon: const GradientIcon(
                                icon: Icons.campaign,
                                rectSize: 26,
                                iconSize: 30,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(hawker.hawkerDetails?.description ?? ""),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Categoria: ${HawkerCategoryEnumExtension.getEnumName(hawker.hawkerDetails!.categories!.first)}",
                          // TODO - está pegando first da category
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Image.asset(
                            hawker.hawkerDetails!.categories != null
                                ? HawkerCategoryEnumExtension.categoryIcon(hawker.hawkerDetails!
                                    .categories!.first) // TODO - está pegando first da category
                                : AppImages.categoryBread,
                            height: 30,
                            width: 30,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Avaliação geral:",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        RatingBar.builder(
                          initialRating: hawker.hawkerDetails?.averageRating ?? 4,
                          ignoreGestures: true,
                          minRating: 1,
                          itemSize: 25,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: kFourthLightColor,
                          ),
                          onRatingUpdate: (rating) => 0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Sobre mim",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(hawker.hawkerDetails!.description!)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
