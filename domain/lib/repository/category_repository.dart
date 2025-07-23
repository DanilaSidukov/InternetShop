library domain;
import '../models/categories/category.dart';
import '../network/utils/response.dart';

export 'package:domain/repository/category_repository.dart';
export 'package:domain/repository/details_repository.dart';
export 'package:domain/repository/products_repository.dart';

abstract interface class CategoryRepository {

  Future<Response<List<Category>>> getCategories();
}
