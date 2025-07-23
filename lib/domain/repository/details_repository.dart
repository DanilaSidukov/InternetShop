
import '../../domain/network/utils/response.dart';
import '../models/products/product.dart';

abstract interface class DetailsRepository {

  Future<Response<Product?>> getDetails(int productId, int categoryId);
}
