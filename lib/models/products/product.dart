
class Product {
  final int productId;
  final String title;
  final String productDescription;
  final int price;
  final double? rating;
  final String? imageUrl;
  final List<String> images;
  final bool isAvailableForSale;

  const Product({
    required this.productId,
    required this.title,
    required this.productDescription,
    required this.price,
    this.rating,
    required this.imageUrl,
    required this.images,
    required this.isAvailableForSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
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
}
