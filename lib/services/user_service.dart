import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  Future updateUserData(
    String? uid,
    String? unitKerja,
  ) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    return userCollection.doc(uid).set({'unitKerja': unitKerja});
  }
}
