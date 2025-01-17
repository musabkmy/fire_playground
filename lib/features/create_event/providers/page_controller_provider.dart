import 'package:flutter/material.dart';

class PageControllerProvider with ChangeNotifier {
  PageController? _pageController;
  final int _numberOfPages = 3;

  PageController get pageController => _pageController ??= PageController();
  num? get page => _pageController == null ? 0 : _pageController!.page;
  // num get pageIndex => _pageController.page ?? _pageController.initialPage;
  int get numberOfPages => _numberOfPages;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }
}
