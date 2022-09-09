/*
 * Created by Kairo Amorim on 01/09/2022 01:01
 * Copyright© 2022. All rights reserved.
 * Last modified 01/09/2022 01:01
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/ui/styles/color.dart';

class HomeDrawerWidget extends StatelessWidget {
  final bool isLogged;
  final User? user;
  final VoidCallback? loginOnPressed;
  final VoidCallback? registerOnPressed;
  final VoidCallback? logoutOnPressed;

  const HomeDrawerWidget(
      {Key? key,
      required this.isLogged,
      this.loginOnPressed,
      this.registerOnPressed,
      this.user,
      this.logoutOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                kFourthLightColor,
                kThirdColor,
              ],
              stops: [0, 0.55],
            )),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              if (isLogged && user != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                        radius: 30,
                        child: user!.base64Photo != null
                            ? Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(base64Decode(user!.base64Photo!))),
                                  borderRadius: const BorderRadius.all(Radius.circular(1000)),
                                  color: kPrimaryLightColor,
                                ),
                              )
                            : null),
                    Text("Bem vindo, ${user!.name}"),
                  ],
                )
              ]
            ]),
          ),
          if (!isLogged) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: loginOnPressed, child: const Text("Login")),
                const Text("ou"),
                TextButton(onPressed: registerOnPressed, child: const Text("Cadastro"))
              ],
            )
          ] else ...[
            TextButton(onPressed: logoutOnPressed, child: const Text("Sair"))
          ]
        ],
      ),
    );
  }
}
