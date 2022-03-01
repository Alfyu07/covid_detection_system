import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class Utils {
  static void showSnackBar(BuildContext context, String text, Color? color) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: color,
        ),
      );
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static DateTime? toDateTime(Timestamp? value) {
    if (value == null) return null;

    return value.toDate();
  }
}
