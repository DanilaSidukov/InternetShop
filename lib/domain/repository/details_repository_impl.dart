
import 'package:internet_shop/models/products/product.dart';

import '../../data/network/products/products_api.dart';
import '../../data/network/utils/response.dart';
import '../../data/repository/details_repository.dart';

final class DetailsRepositoryImpl implements DetailsRepository {

  final ProductsApi productsApi;

  DetailsRepositoryImpl({required this.productsApi});

  @override
  Future<Response<Product?>> getDetails(int productId) {
    final response = productsApi.fetchDetails(productId);
    return response;
  }
}
