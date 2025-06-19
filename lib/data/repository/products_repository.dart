
import 'package:internet_shop/models/products/product.dart';

import '../network/utils/response.dart';

abstract interface class ProductsRepository {

  Future<Response<List<Product>>> getProducts(
    int categoryId,
    [int offset = 0]
  );
}
