/*
 * Created by Kairo Amorim on 23/11/2022 09:17
 * Copyright© 2022. All rights reserved.
 * Last modified 23/11/2022 09:17
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:hawker_geo/ui/styles/text.dart';

class AcceptCallWidget extends StatelessWidget {
  final User caller;

  const AcceptCallWidget({
    Key? key,
    required this.caller,
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
                "Recebendo chamado de:",
                style: boldTitle.copyWith(fontSize: 25),
              ),
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
                      child: caller.base64Photo != null
                          ? Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(base64Decode(caller.base64Photo!))),
                                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                color: kPrimaryLightColor,
                              ),
                            )
                          : null),
                  const SizedBox(
                    width: 10,
                  ),

                  const Text("Usuário Cliente 001",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
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
                    "Avaliação geral:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  RatingBar.builder(
                    initialRating: 4,
                    // todo - adicionar averageRating ao User
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
                height: 12,
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: kPrimaryLightColor, borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            splashRadius: 50,
                          ),
                        ),
                        Text(
                          "Aceitar",
                          style: boldTitle.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: kSecondDarkColor, borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            splashRadius: 50,
                          ),
                        ),
                        Text(
                          "Recusar",
                          style: boldTitle.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
