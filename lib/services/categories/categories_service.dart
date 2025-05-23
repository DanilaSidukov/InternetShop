import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:internet_shop/services/network/utils/response.dart';

import '../../models/categories/category.dart' as models;
import '../../presentation/app.dart';

class CategoriesService extends ChangeNotifier {

  final _app = App();
  List<models.Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<models.Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    final result = await _app.categoryApi.fetchCategories();
    switch (result) {
      case Success():
        _categories = result.data;
        _error = null;
      case Error():
        _error = result.message;
        _categories = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
