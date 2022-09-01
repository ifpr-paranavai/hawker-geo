/*
 * Created by Kairo Amorim on 31/08/2022 22:47
 * Copyright© 2022. All rights reserved.
 * Last modified 31/08/2022 22:47
 */

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawker_geo/core/model/hawker_category_enum.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/core/utils/app_images.dart';
import 'package:hawker_geo/ui/shared/custom-behavior.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:hawker_geo/ui/styles/text.dart';

class HawkerDetailsWidget extends StatelessWidget {
  final User hawker;

  const HawkerDetailsWidget({Key? key, required this.hawker}) : super(key: key);

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
                        children: [const CircleAvatar(), Text(hawker.name!, style: boldTitle)],
                      ),
                    ),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Categoria:",
                          style: TextStyle(fontSize: 16),
                        ),
                        Image.asset(
                          hawker.hawkerCategory != null
                              ? HawkerCategoryEnumExtension.categoryIcon(hawker.hawkerCategory!)
                              : AppImages.categoryBread,
                          height: 30,
                          width: 30,
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Avaliação geral:"),
                        RatingBar.builder(
                          initialRating: 3.5,
                          ignoreGestures: true,
                          minRating: 1,
                          itemSize: 25,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: kFourthColor,
                          ),
                          onRatingUpdate: (rating) => 0,
                        )
                      ],
                    )
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
