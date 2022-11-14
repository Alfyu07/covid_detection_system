import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';

class AdminServices {
  final FirebaseFirestore firestore;

  AdminServices(this.firestore);

  Future<int> getImagesCount() async {
    int result = 0;
    final doc = await firestore.collection('diagnosis').get();
    final List<DocumentSnapshot> count = doc.docs;
    // ignore: join_return_with_assignment
    result = count.length;
    return result;
  }

  Future<int> getUsersCount() async {
    int result = 0;
    final doc = await firestore.collection('users').get();
    final List<DocumentSnapshot> count = doc.docs;
    // ignore: join_return_with_assignment
    result = count.length;
    return result;
  }

  Future<int> getFeedbacksCount() async {
    int result = 0;
    final doc = await firestore.collection('saran').get();
    final List<DocumentSnapshot> count = doc.docs;
    // ignore: join_return_with_assignment
    result = count.length;
    return result;
  }

  Future<List<UserModel>> queryUsers(String query) async {
    final List<UserModel> result = [];

    final QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('nameToLowerCase', isGreaterThanOrEqualTo: query)
        .where('nameToLowerCase', isLessThan: '${query}z')
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      final Map<String, dynamic> data =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      final user = UserModel.fromJson(data);
      if (user.role == 1) {
        result.add(user);
      }
    }
    return result;
  }

  Future<ApiReturnValue<UserModel>> getUser(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final UserModel user = UserModel.fromJson(data);
      return ApiReturnValue(value: user);
    } catch (e) {
      return ApiReturnValue(message: "there's something wrong");
    }
  }

  Future<List<Saran>> queryFeedbacks(String query) async {
    final List<Saran> result = [];

    final QuerySnapshot querySnapshot = await firestore
        .collection('saran')
        .where('text', isGreaterThanOrEqualTo: query)
        .where('text', isLessThan: '${query}z')
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      final Map<String, dynamic> data =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      Saran saran = Saran.fromJson(data);

      final returnValue = await getUser(saran.idUser!);

      if (returnValue.value != null) {
        result.add(saran.copyWith(user: returnValue.value));
      } else {
        continue;
      }
    }
    return result;
  }
}
