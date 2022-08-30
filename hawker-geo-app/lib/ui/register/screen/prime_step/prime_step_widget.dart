/*
 * Created by Kairo Amorim on 30/08/2022 16:57
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 15:44
 */

import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/register/register_controller.dart';
import 'package:hawker_geo/ui/register/screen/components/register_text_field.dart';
import 'package:hawker_geo/ui/shared/default_next_button.dart';
import 'package:hawker_geo/ui/shared/function_widgets.dart';
import 'package:hawker_geo/ui/styles/text.dart';

import 'prime_step_page.dart';

class RegisterPrimeStepWidget extends State<RegisterPrimeStepPage> {
  final _controller = RegisterController();

  var _passwordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(children: [
            const Center(child: Text("Registre-se", style: boldTitle)),
            const SizedBox(
              height: 50,
            ),
            RegisterTextField(
                hintText: "Nome",
                icon: Icons.person,
                onChanged: (value) {
                  _controller.user.name = value;
                }),
            RegisterTextField(
                hintText: "E-mail",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _controller.user.email = value;
                }),
            RegisterTextField(
              hintText: "Senha",
              icon: Icons.lock,
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
            DefaultNextButton(
              "CRIAR CONTA",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FunctionWidgets().showLoading(context);
                  _controller.registerUser(context);
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
