import 'package:flutter/material.dart';

import '../register_controller.dart';
import 'register_page.dart';

class RegisterWidget extends State<RegisterPage> {
  final _controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(children: [TextFormField()]),
      ),
    );
  }
}
