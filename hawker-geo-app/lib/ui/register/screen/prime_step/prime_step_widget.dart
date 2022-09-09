/*
 * Created by Kairo Amorim on 30/08/2022 16:57
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 15:44
 */

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
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
  var _itensGradient = [kPrimaryLightColor, kPrimaryMediumColor];

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
                    iconGradient: _itensGradient,
                    onChanged: (value) {
                      _controller.user.name = value;
                    }),
                RegisterTextField(
                    hintText: "E-mail",
                    icon: Icons.email,
                    iconGradient: _itensGradient,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      _controller.user.email = value;
                    }),
                RegisterTextField(
                  hintText: "Senha",
                  icon: Icons.lock,
                  iconGradient: _itensGradient,
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
                _getSwitchButton(),
                DefaultNextButton(
                  "CRIAR CONTA",
                  buttonColors: _blobGradient.reversed.toList(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FunctionWidgets().showLoading(context);
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

  _getSwitchButton() {
    return Switch(
        value: true,
        onChanged: (value) {
          setState(() {
            _blobGradient = [
              kFourthLightColor,
              kFourthDarkColor,
            ];
          });
        });
  }
}
