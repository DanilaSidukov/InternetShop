
import 'dart:convert';

import 'package:internet_shop/models/products/product.dart';
import 'package:internet_shop/services/network/base_api.dart';
import 'package:internet_shop/services/network/utils/response.dart';

final class ProductsApi extends BaseApi {

  static const String _endpoint = 'common/product/';

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
              productsJson.map((json) => Product.fromJson(json))
          );
          return Success(products);
        } catch (e) {
          return Error(e.toString());
        }
      },
      onError: (msg) => Error(msg)
    );
  }

  Future<Response<Product?>> fetchDetails(int productId) async {
    final Map<String, int> params = {
      'productId': productId
    };
    final response = await get("${_endpoint}details", params: params);
    return response.when(
        onSuccess: (rawJson) {
          try {
            final Map<String, dynamic> jsonData = json.decode(rawJson);
            final product = Product.fromJson(jsonData['data']);
            return Success(product);
          } catch (e) {
            return Error(e.toString());
          }
        },
        onError: (msg) => Error(msg)
    );
  }
}
