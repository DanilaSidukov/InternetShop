
import 'package:flutter/cupertino.dart';
import 'package:internet_shop/data/repository/details_repository.dart';

import '../../data/network/utils/response.dart';
import '../../models/products/product.dart';

class DetailsService extends ChangeNotifier {

  final DetailsRepository detailsRepository;

  DetailsService({required this.detailsRepository});

  Product? _product;
  bool _isLoading = false;
  String? _error;

  Product? get product => _product;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProductDetails(int productId, int categoryId) async {
    _isLoading = true;
    notifyListeners();

    final result = await detailsRepository.getDetails(productId, categoryId);
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
}
