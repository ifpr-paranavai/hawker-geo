/*
 * Created by Kairo Amorim on 30/08/2022 13:21
 * Copyright (c) 2022. All rights reserved.
 * Last modified 30/08/2022 13:21
 */
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/core/persistence/firestore/user_repository.dart';

class RegisterService {
  final _userRepo = UserRepository();

  registerAuthUser(User user) async {
    return await fb.FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: user.email!, password: user.password!);
  }

  registerObjUser(User user) {
    try {
      return _userRepo.saveOrUpdate(user);
    } catch (e) {
      rethrow;
    }
  }
}
