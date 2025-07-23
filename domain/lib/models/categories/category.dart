
import '../../db/database_helper.dart';

class Category {
  final String date;
  final int categoryId;
  final String title;
  final String? imageUrl;
  final int hasSubcategories;
  final String fullName;
  final String categoryDescription;

  const Category(
    this.date,
    {required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.hasSubcategories,
    required this.fullName,
    required this.categoryDescription,
  });

  Map<String, dynamic> mapToDatabase() {
    final table = DatabaseHelper.category;
    return {
      table.date: date,
      table.id: categoryId,
      table.title: title,
      table.url: imageUrl ?? '',
      table.hasSubcategories: hasSubcategories,
      table.fullName: fullName,
      table.categoryDescription: categoryDescription
    };
  }

  factory Category.fromJson(Map<String, dynamic> json, String date) {
    return switch (json) {
      {'categoryId' : int categoryId,
      'title' : String title,
      'imageUrl' : String? imageUrl,
      'hasSubcategories' : int hasSubcategories,
      'fullName' : String fullName,
      'categoryDescription' : String categoryDescription
      } => Category(
              date,
              categoryId: categoryId,
              title: title,
              imageUrl: imageUrl,
              hasSubcategories: hasSubcategories,
              fullName: fullName,
              categoryDescription: categoryDescription
          ),
      _ => throw const FormatException('Failed to load album.')
    };
  }

  factory Category.fromDatabase(Map<String, dynamic> json) {
    return switch (json) {
     {
     'categoryId': int categoryId,
     'date': String date,
     'url': String imageUrl,
     'title': String title,
     'hasSubcategories' : int hasSubcategories,
     'fullName' : String fullName,
     'categoryDescription' : String categoryDescription
    } => Category(
       date,
       categoryId: categoryId,
       title: title,
       imageUrl: imageUrl,
       hasSubcategories: hasSubcategories,
       fullName: fullName,
       categoryDescription: categoryDescription
     ),
    _ => throw const FormatException('Failed to load album.')
    };
  }
}