/*
 * Created by Kairo Amorim on 23/11/2022 09:35
 * Copyright© 2022. All rights reserved.
 * Last modified 23/11/2022 09:35
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:hawker_geo/ui/styles/text.dart';

class ReviewUserWidget extends StatelessWidget {
  final User user;

  const ReviewUserWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Nos conte como foi o atendimento!",
                textAlign: TextAlign.center,
                style: boldTitle.copyWith(fontSize: 20),
              ),
              const Divider(color: Colors.black, height: 20, endIndent: 20, thickness: 1),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CircleAvatar(
                  //     radius: 30,
                  //     child: Container(
                  //       decoration: const BoxDecoration(
                  //         image: DecorationImage(
                  //             fit: BoxFit.cover,
                  //             image: NetworkImage(
                  //                 "https://www.masslive.com/resizer/kNl3qvErgJ3B0Cu-WSBWFYc1B8Q=/arc-anglerfish-arc2-prod-advancelocal/public/W5HI6Y4DINDTNP76R6CLA5IWRU.jpeg")),
                  //         borderRadius: BorderRadius.all(Radius.circular(1000)),
                  //         color: kPrimaryLightColor,
                  //       ),
                  //     )),
                  CircleAvatar(
                      radius: 30,
                      child: user.base64Photo != null
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(base64Decode(user.base64Photo!))),
                                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                color: kPrimaryLightColor,
                              ),
                            )
                          : null),
                  const SizedBox(
                    width: 10,
                  ),

                  Text(user.name!,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  // IconButton(
                  //     onPressed: callButtonOnPressed,
                  //     icon: const GradientIcon(
                  //       icon: Icons.campaign,
                  //       rectSize: 26,
                  //       iconSize: 30,
                  //     ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Nota:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    itemSize: 35,
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
                height: 12,
              ),
              const Text(
                "Descrição:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Material(
                color: Colors.transparent,
                child: Container(
                  color: Colors.grey.withOpacity(0.2),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 4, //or null
                      decoration: InputDecoration.collapsed(
                        hintText: "Comente sobre o atendimento...",
                        // fillColor: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "Atendimento rápido",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "Boa conversa",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
