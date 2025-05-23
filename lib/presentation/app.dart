import 'package:internet_shop/services/categories/categories_service.dart';
import 'package:internet_shop/services/network/products/products_api.dart';
import 'package:internet_shop/services/products/details_service.dart';
import 'package:internet_shop/services/products/products_service.dart';

import '../services/network/categories/category_api.dart';

class App {
  static final App _instance = App._internal();

  factory App() => _instance;

  App._internal();

  CategoryApi? _categoryApi;
  CategoriesService? _categoriesService;
  ProductsApi? _productsApi;
  ProductsService? _productsService;
  DetailsService? _detailsService;

  CategoryApi get categoryApi => _categoryApi ??= CategoryApi();
  CategoriesService get categoriesService => _categoriesService ??= CategoriesService();
  ProductsApi get productsApi => _productsApi ??= ProductsApi();
  ProductsService get productsService => _productsService ??= ProductsService();
  DetailsService get detailsService => _detailsService ??= DetailsService();
}
