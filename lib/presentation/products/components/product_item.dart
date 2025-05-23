
import 'package:flutter/material.dart';
import 'package:internet_shop/models/products/product.dart';
import 'package:internet_shop/presentation/extensions.dart';

import '../../details/details_page.dart';

Widget productItem(BuildContext context, Product product, bool isLast) {
  final typography = Theme.of(context).textTheme;
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsPage(
                      productId: product.productId,
                      title: product.title,
                    )
            )
        );
      },
      child: Padding(
          padding: EdgeInsets.only(
            bottom: isLast ? MediaQuery.of(context).padding.bottom : 0.0,
          ),
          child: Card(
            child: Column(
              children: [
                if (product.imageUrl != null)
                  SizedBox(
                    height: _imageHeight,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_imageRadius),
                      child: Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(_textPadding),
                  child: Text(
                    product.title,
                    style: typography.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_textPadding),
                  child: Text(
                    context.strings.price(product.price),
                    style: typography.titleSmall,
                  ),
                )
              ],
            ),
          )
      )
  );
}

final double _imageHeight = 200;
final double _imageRadius = 6;
const double _textPadding = 10;
