import 'dart:convert';

import 'package:internet_shop/services/network/base_api.dart';
import 'package:internet_shop/services/network/utils/code.dart';

import '../../../models/categories/category.dart';

class CategoryApi extends BaseApi {

  static const String _categoriesEndpoint = 'common/category/list';
  Future<List<Category>> fetchCategories() async {
    final response = await get(_categoriesEndpoint);
    if (response.statusCode == Code.success) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> categoriesJson = jsonData['data']['categories'];
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  }
}