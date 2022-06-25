import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

// ignore: avoid_classes_with_only_static_members
class FirebaseApi {
  static Future<String?> uploadFile(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      final result = await ref.putFile(file);
      final imgUrl = await result.ref.getDownloadURL();
      return imgUrl;
    } on FirebaseException {
      return "null";
    }
  }
}
