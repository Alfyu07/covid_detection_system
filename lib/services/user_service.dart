import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';

class UserService {
  Future updateUserData({
    required UserModel user,
  }) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    return userCollection.doc(user.uid).set(user.toJson());
  }
}
