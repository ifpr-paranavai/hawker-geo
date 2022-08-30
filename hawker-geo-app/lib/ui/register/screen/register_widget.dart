import 'package:flutter/material.dart';
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
            const RegisterTextField(
              hintText: "Nome",
              icon: Icons.person,
            ),
            const RegisterTextField(
              hintText: "E-mail",
              icon: Icons.email,
            ),
            RegisterTextField(
              hintText: "Senha",
              icon: Icons.lock,
              obscureText: _passwordVisible,
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
              onPressed: () {},
            )
          ]),
        ),
      ),
    );
  }
}
