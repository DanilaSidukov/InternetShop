

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internet_shop/models/products/product.dart';
import 'package:internet_shop/presentation/app.dart';
import 'package:internet_shop/services/products/details_service.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key, required this.productId, required this.title
  });

  final int productId;
  final String title;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  late final DetailsService _detailsService;
  bool _isLoading = false;
  String? _error;
  final ScrollController _scrollContainer = ScrollController();

  @override
  void initState() {
    super.initState();
    _detailsService = App().detailsService;
    _loadDetails(widget.productId);
  }

  @override
  void dispose() {
    _scrollContainer.dispose();
    super.dispose();
  }

  Future<void> _loadDetails(int productId) async {
    setState(() => _isLoading = true);
    await _detailsService.fetchProductDetails(productId);
    setState(() {
      _isLoading = false;
      _error = _detailsService.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) => {
        if (didPop) _detailsService.clearData()
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(
            widget.title,
            overflow: TextOverflow.visible,
          ),
        ),
        body: _buildBody(),
      )
    );
  }
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }
    final product = _detailsService.product;
    return ListView(
      controller: _scrollContainer,
      padding: EdgeInsets.all(20),
      children: _productBody(product)
    );
  }

  List<Widget> _productBody (Product? product) {
    if (product != null) {
      return [
        CarouselSlider(
            items: product.images.map((url) {
              return Image.network(url, fit: BoxFit.cover);
            }).toList(),
            options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enableInfiniteScroll: false
            )
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              product.title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            )
        ),
        Text(
          product.productDescription,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.justify,
        )
      ];
    } else {
      return [
        Center(
          heightFactor: 1.0,
          widthFactor: 1.0,
          child: Text(
            "Товар не найден",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        )
      ];
    }
  }
}