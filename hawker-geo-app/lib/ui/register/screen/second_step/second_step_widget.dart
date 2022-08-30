/*
 * Created by Kairo Amorim on 30/08/2022 17:04
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 17:04
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hawker_geo/core/model/gender_enum.dart';
import 'package:hawker_geo/ui/register/register_controller.dart';
import 'package:hawker_geo/ui/register/screen/components/register_dropdown_button.dart';
import 'package:hawker_geo/ui/register/screen/components/register_text_field.dart';
import 'package:hawker_geo/ui/shared/default_next_button.dart';
import 'package:hawker_geo/ui/shared/formatters/phone_input_formatter.dart';
import 'package:hawker_geo/ui/shared/function_widgets.dart';
import 'package:hawker_geo/ui/shared/gradient_icon.dart';
import 'package:hawker_geo/ui/shared/validators.dart';

import 'second_step_page.dart';

class RegisterSecondStepWidget extends State<RegisterSecondStepPage> {
  final _controller = RegisterController();
  final _validators = Validators();

  @override
  void initState() {
    _controller.user = widget.user;
    _controller.user.gender = GenderEnum.values.first;
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
            _genderDropdown(),
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

  Widget _genderDropdown() {
    return RegisterDropdownButton<GenderEnum>(
      value: _controller.user.gender,
      items: GenderEnum.values.map<DropdownMenuItem<GenderEnum>>((GenderEnum value) {
        return DropdownMenuItem<GenderEnum>(
          value: value,
          child: Row(
            children: [
              GradientIcon(
                  icon: GenderEnumExtension.genderIcon(value),
                  rectSize: 30,
                  gradientColors: const [Colors.lightGreen, Color.fromARGB(255, 42, 159, 45)]),
              const SizedBox(width: 10),
              Text(GenderEnumExtension.getEnumName(value)),
            ],
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _controller.user.gender = newValue!;
        });
      },
    );
  }
}
