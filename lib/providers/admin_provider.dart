// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';
import 'package:covidia/services/admin_services.dart';
import 'package:flutter/cupertino.dart';

class AdminProvider extends ChangeNotifier {
  final AdminServices services;

  AdminProvider(this.services);

  List<UserModel> _users = [];
  List<Saran> _feedbacks = [];

  String _query = "";

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String get query => _query;
  List<UserModel> get users => _users;
  List<Saran> get feedbacks => _feedbacks;

  Future<void> getUsers(String q) async {
    isLoading = true;
    _users = await services.queryUsers(q);
    isLoading = false;
  }

  Future<void> getFeedbacks(String q) async {
    isLoading = true;
    _feedbacks = await services.queryFeedbacks(q);
    isLoading = false;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set query(String value) {
    query = value;
    notifyListeners();
  }

  Future<int> getImagesCount() async {
    _isLoading = true;
    final result = await services.getImagesCount();
    _isLoading = false;
    return result;
  }

  Future<int> getUsersCount() async {
    _isLoading = true;
    final result = await services.getUsersCount();
    _isLoading = false;
    return result;
  }

  Future<int> getFeedbacksCount() async {
    _isLoading = true;
    final result = await services.getFeedbacksCount();
    _isLoading = false;
    return result;
  }
}
