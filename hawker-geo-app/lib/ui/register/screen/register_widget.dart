import 'package:flutter/material.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:hawker_geo/ui/styles/text.dart';

import '../../shared/default_next_button.dart';
import '../register_controller.dart';
import 'components/register_text_field.dart';
import 'register_page.dart';

class RegisterWidget extends State<RegisterPage> {
  final _controller = RegisterController();

  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                onChanged: (value) {
                  _controller.user.email = value;
                }),
            RegisterTextField(
              hintText: "Senha",
              icon: Icons.lock,
              obscureText: _passwordVisible,
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
                      icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off)),
                ),
              ),
            ),
            DefaultNextButton(
              "CRIAR CONTA",
              onPressed: () {
                _controller.registerUser();
              },
            )
          ]),
        ),
      ),
    );
  }
}
