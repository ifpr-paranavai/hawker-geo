/*
 * Created by Kairo Amorim on 30/08/2022 16:57
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 15:44
 */

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:hawker_geo/core/model/role_enum.dart';
import 'package:hawker_geo/core/utils/app_images.dart';
import 'package:hawker_geo/ui/register/register_controller.dart';
import 'package:hawker_geo/ui/register/screen/components/register_text_field.dart';
import 'package:hawker_geo/ui/shared/default_next_button.dart';
import 'package:hawker_geo/ui/shared/function_widgets.dart';
import 'package:hawker_geo/ui/styles/color.dart';
import 'package:hawker_geo/ui/styles/text.dart';

import 'prime_step_page.dart';

class RegisterPrimeStepWidget extends State<RegisterPrimeStepPage> {
  final _controller = RegisterController();

  var _passwordVisible = false;

  var _blobGradient = [kPrimaryDarkColor, kPrimaryLightColor];
  var _itemsGradient = [kPrimaryLightColor, kPrimaryMediumColor];
  var _isCustomer = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned(
                top: -280,
                left: -200,
                child: Blob.fromID(
                  id: const ['16-5-674332'],
                  size: 400,
                  styles: BlobStyles(
                      gradient: LinearGradient(colors: _blobGradient)
                          .createShader(const Rect.fromLTRB(0, 0, 300, 300))),
                ),
              ),
              Positioned(
                top: -260,
                right: -170,
                child: Blob.fromID(
                  id: const ['16-5-95'],
                  size: 400,
                  styles: BlobStyles(
                      gradient: LinearGradient(colors: _blobGradient)
                          .createShader(const Rect.fromLTRB(0, 0, 300, 300))),
                ),
              ),
              Positioned(
                bottom: -230,
                left: -230,
                child: Blob.fromID(
                  id: const ['13-2-43'],
                  size: 400,
                  styles: BlobStyles(
                      gradient: LinearGradient(colors: _blobGradient)
                          .createShader(const Rect.fromLTRB(0, 0, 300, 300))),
                ),
              ),
              ListView(children: [
                const SizedBox(
                  height: 80,
                ),
                const Center(child: Text("Registre-se", style: boldTitle)),
                const SizedBox(
                  height: 50,
                ),
                RegisterTextField(
                    hintText: "Nome",
                    icon: Icons.person,
                    iconGradient: _itemsGradient,
                    onChanged: (value) {
                      _controller.user.name = value;
                    }),
                RegisterTextField(
                    hintText: "E-mail",
                    icon: Icons.email,
                    iconGradient: _itemsGradient,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      _controller.user.email = value;
                    }),
                RegisterTextField(
                  hintText: "Senha",
                  icon: Icons.lock,
                  iconGradient: _itemsGradient,
                  obscureText: !_passwordVisible,
                  onChanged: (value) {
                    _controller.user.password = value;
                  },
                  suffixIcon: Transform.scale(
                    scale: 0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          constraints: const BoxConstraints(minHeight: 1, minWidth: 1),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility)),
                    ),
                  ),
                ),
                _switchButton(),
                DefaultNextButton(
                  "CRIAR CONTA",
                  buttonColors: _blobGradient.reversed.toList(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FunctionWidgets().showLoading(context);
                      _controller.user.role ??= RoleEnum.ROLE_CUSTOMER;
                      _controller.registerUser(context);
                    }
                  },
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  _switchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Cliente",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: _isCustomer ? Colors.black : kDisabledColor)),
        Icon(Icons.person, color: _isCustomer ? kPrimaryLightColor : kDisabledColor),
        Switch(
            activeColor: kFourthDarkColor,
            inactiveThumbColor: kPrimaryDarkColor.withOpacity(0.8),
            inactiveTrackColor: kPrimaryLightColor,
            value: !_isCustomer,
            onChanged: (value) {
              setState(() {
                if (_isCustomer) {
                  _controller.user.role = RoleEnum.ROLE_CUSTOMER;
                  _blobGradient = _itemsGradient = [
                    kFourthLightColor,
                    kFourthDarkColor,
                  ];
                } else {
                  _controller.user.role = RoleEnum.ROLE_HAWKER;
                  _blobGradient = _itemsGradient = [kPrimaryDarkColor, kPrimaryLightColor];
                }
              });
              _isCustomer = !_isCustomer;
            }),
        ImageIcon(
          AssetImage(AppImages.hawkerKart),
          color: !_isCustomer ? kFourthDarkColor.withOpacity(0.8) : kDisabledColor,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text("Vendedor",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !_isCustomer ? Colors.black : kDisabledColor)),
        ),
      ],
    );
  }
}
