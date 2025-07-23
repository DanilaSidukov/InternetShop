import 'dart:async';

import 'package:domain/models/categories/category.dart';
import 'package:domain/network/utils/response.dart';
import 'package:domain/repository/category_repository.dart';
import 'package:flutter/foundation.dart' hide Category;

class CategoriesService extends ChangeNotifier {

  final CategoryRepository serviceRepository;
  
  CategoriesService({required this.serviceRepository});

  List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    final result = await serviceRepository.getCategories();
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
