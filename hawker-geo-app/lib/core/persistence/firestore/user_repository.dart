// ignore_for_file: constant_identifier_names, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hawker_geo/core/model/gender_enum.dart';
import 'package:hawker_geo/core/model/hawker_details.dart';
import 'package:hawker_geo/core/model/role_enum.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:hawker_geo/core/model/user.dart';

class UserRepository {
  late CollectionReference userCollection;

  static const String REPO_NAME = 'user';

  UserRepository() {
    userCollection = FirebaseFirestore.instance.collection(REPO_NAME);
  }

  Future<List<User>> find() async {
    var res = await userCollection.get();

    var lista = res.docs.map((doc) => User(
          id: doc.reference.id.toString(),
          active: doc[User.ACTIVE],
          name: doc[User.NAME],
          username: doc[User.USERNAME],
          gender: GenderEnumExtension.fromRaw(doc[User.GENDER]),
          password: doc[User.PASSWORD],
          urlPhoto: doc[User.URL_PHOTO],
          status: StatusEnumExtension.fromRaw(doc[User.STATUS]),
          email: doc[User.EMAIL],
          phoneNumber: doc[User.PHONE_NUMBER],
          role: RoleEnumEnumExtension.fromRaw(doc[User.ROLE]),
        ));
    return lista.toList();
  }

  Future<List<User>> findIcemen() async {
    var res = await userCollection.where('role', isEqualTo: RoleEnum.ROLE_HAWKER.value).get();

    var lista = res.docs.map((doc) => User(
          id: doc.reference.id.toString(),
          active: doc[User.ACTIVE],
          name: doc[User.NAME],
          username: doc[User.USERNAME],
          gender: GenderEnumExtension.fromRaw(doc[User.GENDER]),
          password: doc[User.PASSWORD],
          urlPhoto: doc[User.URL_PHOTO],
          status: StatusEnumExtension.fromRaw(doc[User.STATUS]),
          email: doc[User.EMAIL],
          phoneNumber: doc[User.PHONE_NUMBER],
          role: RoleEnumEnumExtension.fromRaw(doc[User.ROLE]),
        ));
    return lista.toList();
  }

  Future<User?> findByEmail(String email) async {
    var res = await userCollection.where('email', isEqualTo: email).get();
    if (res.docs.isNotEmpty) {
      var doc = res.docs[0];
      return User(
          id: doc.reference.id.toString(),
          active: doc[User.ACTIVE],
          name: doc[User.NAME],
          username: doc[User.USERNAME],
          gender: GenderEnumExtension.fromRaw(doc[User.GENDER]),
          password: doc[User.PASSWORD],
          urlPhoto: doc[User.URL_PHOTO],
          base64Photo: doc[User.BAS64_PHOTO],
          status: StatusEnumExtension.fromRaw(doc[User.STATUS]),
          email: doc[User.EMAIL],
          phoneNumber: doc[User.PHONE_NUMBER],
          role: RoleEnumEnumExtension.fromRaw(doc[User.ROLE]),
          hawkerDetails: doc[User.HAWKER_DETAILS] != null ? HawkerDetails.fromJson(doc[User.HAWKER_DETAILS]) : null);
    } else {
      return null;
    }
  }

  delete(id) async {
    await userCollection.doc(id).set({'ACTIVE': false});
  }

  saveOrUpdate(User user) async {
    if (user.id.toString().isEmpty || user.id.toString() == 'null') {
      await userCollection.doc().set(user.toJson());
      // await userCollection
      //     .add(user.toJson())
      //     .then((DocumentReference doc) => debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
    } else {
      await userCollection.doc(user.id.toString()).set(user.toJson());
    }
  }
}
