import 'package:internet_shop/data/repository/category_repository.dart';
import 'package:internet_shop/data/repository/details_repository.dart';
import 'package:internet_shop/data/repository/products_repository.dart';
import 'package:internet_shop/domain/repository/category_repository_impl.dart';
import 'package:internet_shop/domain/repository/details_repository_impl.dart';
import 'package:internet_shop/domain/repository/products_repository_impl.dart';
import 'package:internet_shop/services/categories/categories_service.dart';
import 'package:internet_shop/services/products/details_service.dart';
import 'package:internet_shop/services/products/products_service.dart';

import '../../data/network/categories/category_api.dart';
import '../../data/network/products/products_api.dart';

base class App {
  static final App _instance = App._internal();

  factory App() => _instance;

  App._internal();

  CategoryApi? _categoryApi;
  CategoryRepository? _categoryRepository;

  ProductsRepository? _productsRepository;
  DetailsRepository? _detailsRepository;
  ProductsApi? _productsApi;

  CategoriesService? _categoriesService;

  CategoryRepository get _categoryRepositoryImpl =>
    _categoryRepository ??= CategoryRepositoryImpl(
        categoryApi: _categoryApi ??= CategoryApi()
    );

  ProductsRepository get _productRepositoryImpl =>
    _productsRepository ??= ProductsRepositoryImpl(
        productsApi: _productsApi ??= ProductsApi()
    );
  DetailsRepository get _detailsRepositoryImpl =>
    _detailsRepository ??= DetailsRepositoryImpl(
        productsApi: _productsApi ??= ProductsApi()
    );

  CategoriesService get categoriesService =>
    _categoriesService ??= CategoriesService(
      serviceRepository: _categoryRepositoryImpl
    );
  ProductsService get productsService => ProductsService(
    productsRepository: _productRepositoryImpl
  );
  DetailsService get detailsService =>  DetailsService(
    detailsRepository: _detailsRepositoryImpl
  );
}
