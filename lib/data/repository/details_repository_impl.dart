
import '../../domain/db/database_helper.dart';
import '../../domain/models/products/product.dart';
import '../../domain/network/products/products_api.dart';
import '../../domain/network/utils/response.dart';
import '../../domain/repository/details_repository.dart';

final class DetailsRepositoryImpl implements DetailsRepository {

  final ProductsApi productsApi;
  final DatabaseHelper databaseHelper;

  DetailsRepositoryImpl({
    required this.productsApi,
    required this.databaseHelper
  });

  @override
  Future<Response<Product?>> getDetails(int productId, int categoryId) async {
    final table = DatabaseHelper.productsTable;
    final productJson = await databaseHelper.getItemFromTableById(
        table: table,
        id: productId
    );

    if (productJson.isNotEmpty && productJson['date'] == databaseHelper.currentDate) {
      final product = Product.fromDatabase(productJson, categoryId);
      return Success(product);
    } else {
      final response = productsApi.fetchDetails(productId, categoryId);
      return response;
    }
  }
}
