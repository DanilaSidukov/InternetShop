import 'package:internet_shop/data/repository/category_repository.dart';
import 'package:internet_shop/data/repository/details_repository.dart';
import 'package:internet_shop/data/repository/products_repository.dart';
import 'package:internet_shop/domain/db/database_helper.dart';
import 'package:internet_shop/domain/repository/category_repository_impl.dart';
import 'package:internet_shop/domain/repository/details_repository_impl.dart';
import 'package:internet_shop/domain/repository/products_repository_impl.dart';
import 'package:internet_shop/presentation/categories/categories_service.dart';
import 'package:internet_shop/presentation/details/details_service.dart';
import 'package:internet_shop/presentation/products/products_service.dart';

import '../../data/network/categories/category_api.dart';
import '../../data/network/products/products_api.dart';
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
