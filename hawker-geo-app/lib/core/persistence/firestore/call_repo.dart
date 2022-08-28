// ignore_for_file: constant_identifier_names, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hawker_geo/core/model/call.dart';
import 'package:hawker_geo/core/model/status_enum.dart';
import 'package:hawker_geo/core/model/user.dart';

class CallRepo {
  late CollectionReference callCollection;

  static const String REPO_NAME = 'call';

  CallRepo() {
    callCollection = FirebaseFirestore.instance.collection(REPO_NAME);
  }

  Future<List<Call>> find() async {
    var res = await callCollection.get();

    var lista = res.docs.map((doc) => Call(
          id: doc.reference.id.toString(),
          active: doc[Call.ACTIVE],
          receiver: User.fromJson(doc[Call.RECEIVER]),
          caller: User.fromJson(doc[Call.CALLER]),
          startTime: DateTime.parse(doc[Call.START_TIME]),
          endTime: DateTime.parse(doc[Call.END_TIME]),
          status: StatusEnumExtension.fromRaw(doc[Call.STATUS]),
        ));
    return lista.toList();
  }

  delete(id) async {
    await callCollection.doc(id).set({Call.ACTIVE: false});
  }

  saveOrUpdate(Call call) async {
    if (call.id.toString().isEmpty || call.id.toString() == 'null') {
      await callCollection.doc().set(call.toJson());
    } else {
      await callCollection.doc(call.id.toString()).set(call.toJson());
    }
  }
}