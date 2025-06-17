import 'package:internet_shop/services/categories/categories_service.dart';
import 'package:internet_shop/services/network/products/products_api.dart';
import 'package:internet_shop/services/products/details_service.dart';
import 'package:internet_shop/services/products/products_service.dart';

import '../services/network/categories/category_api.dart';

base class App {
  static final App _instance = App._internal();

  factory App() => _instance;

  App._internal();

  CategoryApi? _categoryApi;
  CategoriesService? _categoriesService;
  ProductsApi? productsApi;

  CategoriesService get categoriesService => _categoriesService ??= CategoriesService(
    categoryApi: _categoryApi ??= CategoryApi()
  );
  ProductsService get productsService => ProductsService(
    productsApi: productsApi ??= ProductsApi()
  );
  DetailsService get detailsService =>  DetailsService(
    productsApi: productsApi ??= ProductsApi()
  );
}
