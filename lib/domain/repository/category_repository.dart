
import '../../domain/network/utils/response.dart';
import '../models/categories/category.dart';

abstract interface class CategoryRepository {

  Future<Response<List<Category>>> getCategories();
}
