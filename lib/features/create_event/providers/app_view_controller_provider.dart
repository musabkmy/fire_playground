import 'package:flutter/material.dart';

class AppViewControllerProvider with ChangeNotifier {
  bool _showErrorLayout = false;

  bool get getShowErrorLayout => _showErrorLayout;
  void showErrorLayout(bool value) {
    _showErrorLayout = value;
    notifyListeners();
  }
}
