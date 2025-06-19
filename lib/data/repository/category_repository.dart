
import 'package:internet_shop/models/categories/category.dart';

import '../network/utils/response.dart';

abstract interface class CategoryRepository {

  Future<Response<List<Category>>> getCategories();
}
