
import '../../domain/network/utils/response.dart';
import '../models/products/product.dart';

abstract interface class ProductsRepository {

  Future<Response<List<Product>>> getProducts(
    int categoryId,
    [int offset = 0]
  );
}
