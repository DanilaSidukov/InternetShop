import 'package:internet_shop/services/categories/categories_service.dart';
import 'package:internet_shop/services/network/products/products_api.dart';
import 'package:internet_shop/services/products/details_service.dart';
import 'package:internet_shop/services/products/products_service.dart';

import '../services/network/catalog/category_api.dart';

class App {
  static final App _instance = App._internal();

  factory App() => _instance;

  App._internal();

  late final CategoryApi categoryApi;
  late final CategoriesService catalogDataService;
  late final ProductsApi productsApi;
  late final ProductsService productsService;
  late final DetailsService detailsService;

  void init() {
    categoryApi = CategoryApi();
    catalogDataService = CategoriesService();
    productsService = ProductsService();
    productsApi = ProductsApi();
    detailsService = DetailsService();
  }
}
