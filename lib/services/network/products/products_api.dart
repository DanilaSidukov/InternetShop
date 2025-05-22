
import 'dart:convert';

import 'package:internet_shop/models/products/product.dart';
import 'package:internet_shop/services/network/base_api.dart';
import 'package:internet_shop/services/network/utils/code.dart';

class ProductsApi extends BaseApi {

  static const String _endpoint = 'common/product/';

  Future <List<Product>> fetchProducts(int categoryId, [int offset = 0]) async {
    Map<String, int> params = {
      'categoryId': categoryId,
    };
    if (offset != 0) {
      params['offset'] = offset;
    }
    final response = await get("${_endpoint}list", params: params);
    if (response.statusCode == Code.success) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> productsJson = jsonData['data'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<Product?> fetchDetails(int productId) async {
    final Map<String, int> params = {
      'productId': productId
    };
    final response = await get("${_endpoint}details", params: params);
    if (response.statusCode == Code.success) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return Product.fromJson(jsonData['data']);
    } else {
      throw Exception('Failed to load product: ${response.statusCode}');
    }
  }
}
