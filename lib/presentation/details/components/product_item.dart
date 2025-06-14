
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internet_shop/presentation/theme/extensions.dart';

import '../../../models/products/product.dart';

List<Widget> productDetailsItems(BuildContext context, Product? product) {
  final typography = Theme.of(context).textTheme;
  if (product != null) {
    return [
      CarouselSlider(
        items: product.images.map((url) {
          return Image.network(url, fit: BoxFit.cover);
        }).toList(),
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height / 3,
          autoPlay: true,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: _textPadding),
        child: Text(
          product.title,
          style: typography.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
      Text(
        product.productDescription,
        style: typography.titleMedium,
        textAlign: TextAlign.justify,
      ),
    ];
  } else {
    return [
      Center(
        heightFactor: _textFraction,
        widthFactor: _textFraction,
        child: Text(
          context.strings.product_not_found,
          style: typography.titleLarge,
        ),
      ),
    ];
  }
}

final double _textPadding = 12;
final double _textFraction = 1.0;
