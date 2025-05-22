
import 'package:flutter/cupertino.dart';
import 'package:internet_shop/presentation/app.dart';

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

    try {
      _product = await _app.productsApi.fetchDetails(productId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _product = null;
    _isLoading = false;
    _error = null;
  }
}
