import 'dart:convert';

import 'package:internet_shop/domain/db/database_helper.dart';

class Product {
  final int categoryId;
  final String date;
  final int productId;
  final String title;
  final String productDescription;
  final int price;
  final double? rating;
  final String? imageUrl;
  final List<String> images;
  final bool isAvailableForSale;

  const Product(
    this.categoryId,
    this.date,
    {required this.productId,
    required this.title,
    required this.productDescription,
    required this.price,
    this.rating,
    required this.imageUrl,
    required this.images,
    required this.isAvailableForSale,
  });

  Map<String, dynamic> mapToDatabase() {
    final table = DatabaseHelper.product;
    final String imagesList = json.encode(images);
    return {
      table.id: productId,
      table.date: date,
      table.categoryId: categoryId,
      table.title: title,
      table.description: productDescription,
      table.price: price,
      table.image: imageUrl ?? '',
      table.images: imagesList,
      table.rating: rating,
      table.isAvailableForSale: isAvailableForSale ? 1 : 0
    };
  }

  factory Product.fromJson(Map<String, dynamic> json, int categoryId, String date) {
    return switch (json) {
      {
      'productId': int productId,
      'title': String title,
      'productDescription': String productDescription,
      'price': int price,
      'imageUrl': String? imageUrl,
      'images': List<dynamic> images,
      'isAvailableForSale': int isAvailableForSale,
      } =>
          Product(
            categoryId,
            date,
            productId: productId,
            title: title,
            productDescription: productDescription,
            price: price,
            rating: json['rating'] as double?,
            imageUrl: imageUrl,
            images: images.cast<String>(),
            isAvailableForSale: isAvailableForSale == 1,
          ),
      _ => throw const FormatException('Failed to parse product'),
    };
  }

  factory Product.fromDatabase(Map<String, dynamic> row, int categoryId) {
    return switch (row) {
      {
      'id': int productId,
      'title': String title,
      'description': String productDescription,
      'price': int price,
      'image': String? imageUrl,
      'images': String images,
      'isAvailableForSale': int isAvailableForSale,
      'date': String date
      } => Product(
            categoryId,
            date,
            productId: productId,
            title: title,
            productDescription: productDescription,
            price: price,
            rating: row['rating'] as double?,
            imageUrl: imageUrl,
            images: List<String>.from(json.decode(images)),
            isAvailableForSale: isAvailableForSale == 1,
          ),
      _ => throw const FormatException('Failed to parse product'),
    };
  }
}
