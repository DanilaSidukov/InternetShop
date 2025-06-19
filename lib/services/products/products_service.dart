
import 'package:flutter/cupertino.dart';
import 'package:internet_shop/models/products/product.dart';

import '../../data/network/utils/response.dart';
import '../../data/repository/products_repository.dart';

class ProductsService extends ChangeNotifier {

  final ProductsRepository productsRepository;

  ProductsService({required this.productsRepository});

  final List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts(int categoryId, [int offset = 0]) async {
    _isLoading = true;
    notifyListeners();

    final result = await productsRepository.getProducts(categoryId, offset);
    switch (result) {
      case Success():
        _products.addAll(result.data);
        _error = null;
      case Error():
        _error = result.message;
    }
    _isLoading = false;
    notifyListeners();
  }
}
