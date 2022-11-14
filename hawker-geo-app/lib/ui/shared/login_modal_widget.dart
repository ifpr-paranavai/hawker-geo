// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hawker_geo/ui/register/screen/prime_step/prime_step_page.dart';
import 'package:hawker_geo/ui/styles/custom_router.dart';

import '../../core/model/login.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({Key? key, this.onLogged}) : super(key: key);
  final Function(LoginDTO)? onLogged;

  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Entre em sua conta",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          TextField(
            onChanged: (val) => setState(() {
              email = val;
            }),
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            onChanged: (val) => setState(() {
              password = val;
            }),
            obscureText: true,
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              labelText: "Senha",
              border: OutlineInputBorder(),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: ElevatedButton(
              onPressed: () => widget.onLogged!(LoginDTO(password: password, email: email)),
              child: const Text(
                "Entrar",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // FractionallySizedBox(
          //   widthFactor: 0.8,
          //   child: OutlinedButton(
          //     onPressed: () => CustomRouter.pushPage(context, const RegisterPrimeStepPage()),
          //     child: const Text(
          //       "Não tenho conta",
          //       style: TextStyle(fontSize: 18),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
