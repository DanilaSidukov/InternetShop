
import 'package:internet_shop/data/repository/products_repository.dart';

import '../../data/network/products/products_api.dart';
import '../../data/network/utils/response.dart';
import '../../models/products/product.dart';

final class ProductsRepositoryImpl implements ProductsRepository {

  final ProductsApi productsApi;

  ProductsRepositoryImpl({required this.productsApi});

  @override
  Future<Response<List<Product>>> getProducts(
    int categoryId,
    [int offset = 0]
  ) async {
    final response = productsApi.fetchProducts(categoryId, offset);
    return response;
  }
}
