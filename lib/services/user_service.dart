import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  Future updateUserData(
    String? uid,
  ) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    return userCollection.doc(uid).set({
      'role': 1,
    });
  }
}
