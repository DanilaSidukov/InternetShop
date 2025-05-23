
import 'package:flutter/cupertino.dart';
import 'package:internet_shop/presentation/app.dart';
import 'package:internet_shop/services/network/utils/response.dart';

import '../../models/products/product.dart';

class DetailsService extends ChangeNotifier {

  final _app = App();
  Product? _product;
  bool _isLoading = false;
  String? _error;

  Product? get product => _product;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProductDetails(int productId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _app.productsApi.fetchDetails(productId);
    switch (result) {
      case Success():
        _product = result.data;
        _error = null;
      case Error():
        _error = result.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  /// Метод для очистки данных, чтобы не пересоздавать экземпляр класса
  /// и избежать сохранения данных при открытии нового экрана.
  void clearData() {
    _product = null;
    _isLoading = false;
    _error = null;
  }
}
