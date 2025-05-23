
import 'package:flutter/material.dart';

import '../../../models/categories/category.dart';
import '../../products/products_grid_page.dart';

Widget buildCategoryItem(BuildContext context, Category category) {
  final typography = Theme.of(context).textTheme;
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductGridPage(
                      categoryId: category.categoryId
                  )
          )
      );
    },
    child: Card(
      child: Column(
        children: [
          if (category.imageUrl != null)
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_imageRadius),
                child: Image.network(
                  category.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(_textPadding),
            child: Text(
              category.title,
              style: typography.titleMedium,
            ),
          ),
        ],
      ),
    ),
  );
}

const double _textPadding = 8.0;
final double _imageRadius = 6;
