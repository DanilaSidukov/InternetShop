
import 'package:flutter/cupertino.dart';
import 'package:internet_shop/models/products/product.dart';
import 'package:internet_shop/presentation/app.dart';

class ProductsService extends ChangeNotifier {

  final _app = App();
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts(int categoryId, [int offset = 0]) async {
    _isLoading = true;
    notifyListeners();

    try {

      List<Product> newProducts = await _app.productsApi.fetchProducts(
          categoryId, offset
      );
      _products.addAll(newProducts);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _products = [];
    _isLoading = false;
    _error = null;
  }
}
