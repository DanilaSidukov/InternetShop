
import '../../data/network/categories/category_api.dart';
import '../../data/network/utils/response.dart';
import '../../data/repository/category_repository.dart';
import '../../models/categories/category.dart';

final class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApi categoryApi;

  CategoryRepositoryImpl({required this.categoryApi});

  @override
  Future<Response<List<Category>>> getCategories() async {
    final response = await categoryApi.fetchCategories();
    return response;
  }
}
