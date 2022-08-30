/*
 * Created by Kairo Amorim on 30/08/2022 17:04
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 17:04
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hawker_geo/ui/register/register_controller.dart';
import 'package:hawker_geo/ui/register/screen/components/register_text_field.dart';
import 'package:hawker_geo/ui/shared/default_next_button.dart';
import 'package:hawker_geo/ui/shared/formatters/phone_input_formatter.dart';
import 'package:hawker_geo/ui/shared/function_widgets.dart';
import 'package:hawker_geo/ui/shared/validators.dart';

import 'second_step_page.dart';

class RegisterSecondStepWidget extends State<RegisterSecondStepPage> {
  final _controller = RegisterController();
  final _validators = Validators();

  @override
  void initState() {
    _controller.user = widget.user;
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(children: [
            // const Center(child: Text("Registre-se", style: boldTitle)),
            const SizedBox(
              height: 50,
            ),
            RegisterTextField(
                hintText: "Apelido",
                icon: Icons.person,
                onChanged: (value) {
                  _controller.user.name = value;
                }),
            RegisterTextField(
                hintText: "Celular",
                icon: Icons.email,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, PhoneInputFormatter()],
                validator: (value) => _validators.phoneValidator(value),
                onChanged: (value) {
                  var number = value.replaceAll(" ", "");
                  number = number.replaceAll(RegExp(r'[^0-9]'), "");
                  _controller.user.phoneNumber = number;
                }),
            DefaultNextButton(
              "FINALIZAR",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FunctionWidgets().showLoading(context);
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
