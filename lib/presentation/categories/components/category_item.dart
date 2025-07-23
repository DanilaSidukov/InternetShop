
import 'package:flutter/material.dart';
import 'package:internet_shop/presentation/common/components/loader.dart';

import '../../../domain/models/categories/category.dart';
import '../../products/products_grid_page.dart';

final class CategoryItem extends StatelessWidget {

  final Category category;

  const CategoryItem(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_imageRadius),
                      child: Image.network(
                        category.imageUrl!,
                        loadingBuilder: (context, child, progress) {
                          return progress == null ? child : const Loader();
                        },
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  )
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
}

const double _textPadding = 8.0;
final double _imageRadius = 6;
