import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../domain/models/categories/category.dart';
import '../base_api.dart';
import '../utils/response.dart';

final class CategoryApi extends BaseApi {

  static const String _categoriesEndpoint = 'common/category/list';

  final _currentDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now());

  Future<Response<List<Category>>> fetchCategories() async {
    final response = await get(_categoriesEndpoint);

    return response.when(
      onSuccess: (rawJson) {
        try {
          final jsonData = json.decode(rawJson);
          final categoriesJson = jsonData['data']['categories'];
          final categories = List<Category>.from(
            categoriesJson.map((json) => Category.fromJson(json, _currentDate)),
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
