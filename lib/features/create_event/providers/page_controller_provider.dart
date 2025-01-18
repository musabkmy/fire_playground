import 'package:flutter/material.dart';

class PageControllerProvider with ChangeNotifier {
  final PageController _pageController;
  final int _numberOfPages = 3;

  PageControllerProvider() : _pageController = PageController() {
    debugPrint('controller generated');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(_pageListener);
    });
  }

  PageController get pageController => _pageController;
  num get page => _pageController.page ?? 0;
  // num get pageIndex => _pageController.page ?? _pageController.initialPage;
  int get numberOfPages => _numberOfPages;

  void nextPage(
      {Duration duration = const Duration(milliseconds: 300),
      Curve curve = Curves.ease}) {
    if (page < numberOfPages) {
      _pageController.nextPage(duration: duration, curve: curve);
    }
  }

  void previousPage(
      {Duration duration = const Duration(milliseconds: 300),
      Curve curve = Curves.ease}) {
    if (page > 0) {
      _pageController.previousPage(duration: duration, curve: curve);
    }
  }

  void _pageListener() {
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }
}
