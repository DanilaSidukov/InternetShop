import 'dart:async';

import 'package:flutter/foundation.dart' hide Category;
import 'package:internet_shop/data/repository/category_repository.dart';

import '../../data/network/utils/response.dart';
import '../../models/categories/category.dart';

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
