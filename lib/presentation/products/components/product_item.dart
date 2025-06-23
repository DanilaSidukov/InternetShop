
import 'package:flutter/material.dart';
import 'package:internet_shop/models/products/product.dart';
import 'package:internet_shop/presentation/common/components/loader.dart';
import 'package:internet_shop/presentation/theme/extensions.dart';

import '../../details/details_page.dart';

final class ProductItem extends StatelessWidget {

  final Product product;
  final bool isLast;

  const ProductItem(this.product, this.isLast, {super.key});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    return GestureDetector(
        key: ValueKey(product.productId),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsPage(
                        categoryId: product.categoryId,
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
                          loadingBuilder: (context, child, progress) {
                            return progress == null
                              ? child
                              : const Loader(
                                height: _loaderSize,
                                width: _loaderSize
                            );
                          },
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
}

const double _loaderSize = 50.0;
final double _imageHeight = 200;
final double _imageRadius = 6;
const double _textPadding = 10;
