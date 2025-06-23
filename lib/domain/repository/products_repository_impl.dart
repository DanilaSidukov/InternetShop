
import 'package:collection/collection.dart';
import 'package:internet_shop/data/repository/products_repository.dart';

import '../../data/network/products/products_api.dart';
import '../../data/network/utils/response.dart';
import '../../models/products/product.dart';
import '../db/database_helper.dart';

final class ProductsRepositoryImpl implements ProductsRepository {

  final ProductsApi productsApi;
  final DatabaseHelper databaseHelper;

  ProductsRepositoryImpl({
    required this.productsApi,
    required this.databaseHelper
  });

  @override
  Future<Response<List<Product>>> getProducts(
    int categoryId,
    [int offset = 0]
  ) async {
    final table = DatabaseHelper.productsTable;
    final items = await databaseHelper.getItemsFromTable(
      table: table,
      where: 'categoryId = ?',
      whereArgs: [categoryId]
    );
    final isDateValid = items.firstWhereOrNull((item) =>
      item['date'] == databaseHelper.currentDate
    );
    if (items.isNotEmpty && offset == 0 && isDateValid != null) {
      final response = items.map((product) =>
          Product.fromDatabase(product, categoryId)
      ).toList();
      return Success(response);
    } else {
      final response = await productsApi.fetchProducts(categoryId, offset);
      if (response case Success()) {
        for (final product in response.data) {
          final map = product.mapToDatabase();
          databaseHelper.insert(table, map);
        }
      }
      return response;
    }
  }
}
