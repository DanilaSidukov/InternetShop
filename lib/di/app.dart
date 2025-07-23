import 'package:data/repository/category_repository_impl.dart';
import 'package:data/repository/details_repository_impl.dart';
import 'package:data/repository/products_repository_impl.dart';
import 'package:domain/db/database_helper.dart';
import 'package:domain/network/categories/category_api.dart';
import 'package:domain/network/products/products_api.dart';
import 'package:domain/repository/category_repository.dart';
import 'package:internet_shop/presentation/categories/categories_service.dart';
import 'package:internet_shop/presentation/details/details_service.dart';
import 'package:internet_shop/presentation/products/products_service.dart';

import '../../presentation/authorization/authorization_service.dart';

base class App {
  static final App _instance = App._internal();

  factory App() => _instance;

  App._internal();

  CategoryApi? _categoryApi;
  ProductsApi? _productsApi;

  CategoryRepository? _categoryRepository;
  ProductsRepository? _productsRepository;
  DetailsRepository? _detailsRepository;

  final DatabaseHelper databaseHelper = DatabaseHelper();

  CategoryRepository get _categoryRepositoryImpl =>
    _categoryRepository ??= CategoryRepositoryImpl(
      categoryApi: _categoryApi ??= CategoryApi(),
      databaseHelper: databaseHelper
    );

  ProductsRepository get _productRepositoryImpl =>
    _productsRepository ??= ProductsRepositoryImpl(
        productsApi: _productsApi ??= ProductsApi(),
        databaseHelper: databaseHelper
    );
  DetailsRepository get _detailsRepositoryImpl =>
    _detailsRepository ??= DetailsRepositoryImpl(
        productsApi: _productsApi ??= ProductsApi(),
        databaseHelper: databaseHelper
    );

  CategoriesService get categoriesService => CategoriesService(
      serviceRepository: _categoryRepositoryImpl
  );
  ProductsService get productsService => ProductsService(
    productsRepository: _productRepositoryImpl
  );
  DetailsService get detailsService =>  DetailsService(
    detailsRepository: _detailsRepositoryImpl
  );

  AuthorizationService get authorizationService => AuthorizationService(

  );
}
