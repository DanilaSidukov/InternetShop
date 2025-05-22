
class Category {

  final int categoryId;
  final String title;
  final String? imageUrl;
  final int hasSubcategories;
  final String fullName;
  final String categoryDescription;

  const Category({
    required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.hasSubcategories,
    required this.fullName,
    required this.categoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'categoryId' : int categoryId,
      'title' : String title,
      'imageUrl' : String? imageUrl,
      'hasSubcategories' : int hasSubcategories,
      'fullName' : String fullName,
      'categoryDescription' : String categoryDescription
      } => Category(
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