/*
 * Created by Kairo Amorim on 30/08/2022 13:21
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 13:21
 */
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:hawker_geo/core/model/user.dart';

class RegisterService {
  registerUser(User user) async {
    await fb.FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: user.email!, password: user.password!);
  }
}
