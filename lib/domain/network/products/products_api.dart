
import 'dart:convert';

import 'package:internet_shop/domain/models/products/product.dart';
import 'package:intl/intl.dart';

import '../base_api.dart';
import '../utils/response.dart';

final class ProductsApi extends BaseApi {

  static const String _endpoint = 'common/product/';
  final _currentDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now());

  Future <Response<List<Product>>> fetchProducts(int categoryId, [int offset = 0]) async {
    Map<String, int> params = {
      'categoryId': categoryId,
    };
    if (offset != 0) {
      params['offset'] = offset;
    }
    final response = await get("${_endpoint}list", params: params);
    return response.when(
      onSuccess: (rawJson) {
        try {
          final Map<String, dynamic> jsonData = json.decode(rawJson);
          final List<dynamic> productsJson = jsonData['data'];
          final products = List<Product>.from(
              productsJson.map((json) => Product.fromJson(json, categoryId, _currentDate))
          );
          return Success(products);
        } catch (e) {
          return Error(e.toString());
        }
      },
      onError: (msg) => Error(msg)
    );
  }

  Future<Response<Product?>> fetchDetails(int productId, int categoryId) async {
    final Map<String, int> params = {
      'productId': productId
    };
    final response = await get("${_endpoint}details", params: params);
    return response.when(
        onSuccess: (rawJson) {
          try {
            final Map<String, dynamic> jsonData = json.decode(rawJson);
            final product = Product.fromJson(jsonData['data'], categoryId, _currentDate);
            return Success(product);
          } catch (e) {
            return Error(e.toString());
          }
        },
        onError: (msg) => Error(msg)
    );
  }
}
