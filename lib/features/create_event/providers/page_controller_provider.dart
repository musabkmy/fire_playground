import 'package:flutter/material.dart';

class PageControllerProvider with ChangeNotifier {
  final PageController _pageController;
  final int _numberOfPages = 3;
  int _currentPageIndex = 0;

  PageControllerProvider() : _pageController = PageController() {
    _pageController.addListener(_pageListener);
  }

  PageController get pageController => _pageController;
  int get numberOfPages => _numberOfPages;
  int get currentPageIndex => _currentPageIndex;

  bool get atDetails => _currentPageIndex == 0;
  bool get atDateAndLocation => _currentPageIndex == 1;
  bool get atLastPage => _currentPageIndex >= _numberOfPages - 1;

  void setCurrentPageIndex(int index) {
    if (_currentPageIndex != index) {
      debugPrint('Updating index to $index');
      _currentPageIndex = index;
      notifyListeners();
    }
  }

  Future<void> nextPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async {
    if (_currentPageIndex < _numberOfPages - 1) {
      await _pageController.animateToPage(
        _currentPageIndex + 1,
        duration: duration,
        curve: curve,
      );
    }
  }

  Future<void> previousPage({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.ease,
  }) async {
    if (_currentPageIndex > 0) {
      await _pageController.animateToPage(
        _currentPageIndex - 1,
        duration: duration,
        curve: curve,
      );
    }
  }

  void _pageListener() {
    final newPageIndex = _pageController.page?.round() ?? 0;
    if (_currentPageIndex != newPageIndex) {
      setCurrentPageIndex(newPageIndex);
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }
}
