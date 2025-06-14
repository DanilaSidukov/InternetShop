import 'dart:convert';

import 'package:internet_shop/services/network/base_api.dart';
import 'package:internet_shop/services/network/utils/response.dart';

import '../../../models/categories/category.dart';

final class CategoryApi extends BaseApi {

  static const String _categoriesEndpoint = 'common/category/list';
  Future<Response<List<Category>>> fetchCategories() async {
    final response = await get(_categoriesEndpoint);

    return response.when(
      onSuccess: (rawJson) {
        try {
          final jsonData = json.decode(rawJson);
          final categoriesJson = jsonData['data']['categories'];
          final categories = List<Category>.from(
            categoriesJson.map((json) => Category.fromJson(json)),
          );
          return Success(categories);
        } catch (e) {
          return Error<List<Category>>('Parsing failed: $e');
        }
      },
      onError: (msg) => Error(msg),
    );
  }
}
