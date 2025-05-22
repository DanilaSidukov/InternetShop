import 'dart:async';

import 'package:flutter/foundation.dart';

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

    try {
      _categories = await _app.categoryApi.fetchCategories();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _categories = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}