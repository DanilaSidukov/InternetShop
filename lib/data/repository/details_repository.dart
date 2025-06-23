
import 'package:internet_shop/models/products/product.dart';

import '../network/utils/response.dart';

abstract interface class DetailsRepository {

  Future<Response<Product?>> getDetails(int productId, int categoryId);
}
