// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hawker_geo/core/model/error/login_error.dart';
import 'package:hawker_geo/core/model/hawker_category_enum.dart';
import 'package:hawker_geo/core/model/login.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/core/persistence/firestore/call_repo.dart';
import 'package:hawker_geo/core/persistence/firestore/user_repo.dart';
import 'package:hawker_geo/core/utils/constants.dart';
import 'package:hawker_geo/ui/register/screen/register_page.dart';
import 'package:hawker_geo/ui/shared/login_modal_widget.dart';
import 'package:hawker_geo/ui/styles/custom_router.dart';
import 'package:latlong2/latlong.dart';

import '../../core/model/call.dart';
import '../../core/model/gender_enum.dart';
import '../../core/model/role_enum.dart';

class HomeController {
  User? _user;
  final UserRepo _userRepo = UserRepo();
  final CallRepo _callRepo = CallRepo();

  User? get user => _user;

  constructor() {
    checkUser();
  }

  checkUser() async {
    var authUser = fb.FirebaseAuth.instance.currentUser;

    if (authUser != null) {
      _user = await _userRepo.findByEmail(authUser.email.toString());
    }
  }

  RoleEnum? getUserRole() {
    return _user?.role;
  }

  bool isLoggedIn() {
    return _user != null ? true : false;
  }

  logout() async {
    await fb.FirebaseAuth.instance.signOut();
    _user = null;
  }

  sendHawkerLocation(LatLng pos) {
    _user!.position = pos;
    _userRepo.saveOrUpdate(_user!);
  }

  clearHawkerPosition() {
    _user!.position = LatLng(0, 0);
    _userRepo.saveOrUpdate(user!);
  }

  goToRegister(BuildContext context) {
    CustomRouter.pushPage(context, const RegisterPage());
  }

  Future<void> showLoginModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => FractionallySizedBox(
          heightFactor: 0.85,
          child: LoginModal(
            onLogged: (login) {
              tryLogin(context, login);
            },
          )),
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
    );
    return;
  }

  Future<LatLng> getClientLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return LatLng(location.latitude, location.longitude);
  }

  docsToUserList(dynamic docs) {
    var users = <User>[];
    docs.forEach((QueryDocumentSnapshot doc) {
      final dynamic data = doc.data();

      if (data[User.ROLE] != null &&
          data[User.STATUS] != null &&
          RoleEnumEnumExtension.fromRaw(data[User.ROLE]) == RoleEnum.ROLE_HAWKER &&
          StatusEnumExtension.fromRaw(data[User.STATUS]) != StatusEnum.I) {
        users.add(User(
          id: doc.reference.id.toString(),
          active: data[User.ACTIVE],
          status: StatusEnumExtension.fromRaw(data[User.STATUS]),
          name: data[User.NAME],
          username: data[User.USERNAME],
          gender: GenderEnumExtension.fromRaw(data[User.GENDER]),
          password: data[User.PASSWORD],
          urlPhoto: data[User.URL_PHOTO],
          email: data[User.EMAIL],
          phoneNumber: data[User.PHONE_NUMBER],
          role: RoleEnumEnumExtension.fromRaw(data[User.ROLE]),
          hawkerCategory: HawkerCategoryEnumExtension.fromRaw(data[User.HAWKER_CATEGORY]),
          position: LatLng.fromJson(data[User.POSITION]),
        ));
      }
    });
    return users;
  }

  docsToCallsList(dynamic docs) {
    var calls = <Call>[];
    docs.forEach((doc) => {
          calls.add(Call(
            id: doc.reference.id.toString(),
            active: doc[Call.ACTIVE],
            receiver: User.fromJson(doc[Call.RECEIVER]),
            caller: User.fromJson(doc[Call.CALLER]),
            startTime: doc[Call.START_TIME] != null
                ? DateTime.parse(doc[Call.START_TIME]).toLocal()
                : doc[Call.START_TIME],
            endTime: doc[Call.END_TIME] != null
                ? DateTime.parse(doc[Call.END_TIME]).toLocal()
                : doc[Call.END_TIME],
            status: StatusEnumExtension.fromRaw(doc[Call.STATUS]),
          ))
        });
    return calls;
  }

  tryLogin(BuildContext context, LoginDTO login) async {
    try {
      await fb.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: login.email!,
        password: login.password!,
      );
      await checkUser();

      if (_user!.status == StatusEnum.I) {
        throw LoginError("Sua conta não foi aprovada pela administração");
      }
      if (_user!.status == StatusEnum.P) {
        throw LoginError("A aprovação da sua conta está pendente");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logado com sucesso"),
        ),
      );
      Navigator.of(context).pop();
    } on fb.FirebaseAuthException catch (err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erro"),
          content: Text(err.toString()),
        ),
      );
      logout();
    } on LoginError catch (err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Erro de Login"),
          content: Text(err.toString()),
        ),
      );
      logout();
    }
  }

  Future<User> createCall(BuildContext context, List<User> icemen, LatLng userLocation) async {
    var closestIceman = icemen.first;

    for (var iceman in icemen) {
      //Se a long + lat do iceman da vez menos a lat + long do user for menor
      // que o salvo na variável então ele está mais perto
      var isClose = ((iceman.position!.latitude + iceman.position!.longitude) -
                  (userLocation.latitude + userLocation.longitude))
              .abs() <
          ((closestIceman.position!.latitude + closestIceman.position!.longitude) -
                  (userLocation.latitude + userLocation.longitude))
              .abs();
      if (isClose) {
        closestIceman = iceman;
      }
    }

    var now = DateTime.now();

    _callRepo.saveOrUpdate(Call(
        active: true,
        caller: _user,
        receiver: closestIceman,
        startTime: now,
        endTime: now.add(const Duration(minutes: CALL_TIMER)),
        status: StatusEnum.A));

    return closestIceman;
  }
}
