
import 'package:collection/collection.dart';
import 'package:domain/db/database_helper.dart';
import 'package:domain/models/categories/category.dart';
import 'package:domain/network/categories/category_api.dart';
import 'package:domain/network/utils/response.dart';
import 'package:domain/repository/category_repository.dart';

final class CategoryRepositoryImpl implements CategoryRepository {

  final CategoryApi categoryApi;
  final DatabaseHelper databaseHelper;

  CategoryRepositoryImpl({
    required this.categoryApi,
    required this.databaseHelper
  });

  @override
  Future<Response<List<Category>>> getCategories() async {
    final table = DatabaseHelper.categoriesTable;
    final items = await databaseHelper.getItemsFromTable(
        table: table
    );
    final isDateValid = items.firstWhereOrNull((category) =>
      category['date'] == databaseHelper.currentDate
    );
    if (items.isNotEmpty && isDateValid != null) {
      final categories = items.map((item) =>
          Category.fromDatabase(item)
      ).toList();
      return Success(categories);
    } else {
      final response = await categoryApi.fetchCategories();
      if (response case Success()) {
        for (final category in response.data) {
          final map = category.mapToDatabase();
          databaseHelper.insert(table, map);
        }
      }
      return response;
    }
  }
}
