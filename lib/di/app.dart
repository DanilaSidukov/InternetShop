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
  ProductsService? _productsService;
  DetailsService? _detailsService;

  ProductsApi get _productsApiData => productsApi ??= ProductsApi();

  CategoriesService get categoriesService => _categoriesService ??= CategoriesService(
    categoryApi: _categoryApi ??= CategoryApi()
  );
  ProductsService get productsService => _productsService ??= ProductsService(
    productsApi: _productsApiData
  );
  DetailsService get detailsService => _detailsService ??= DetailsService(
    productsApi: _productsApiData
  );
}
