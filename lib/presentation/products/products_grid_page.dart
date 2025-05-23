
import 'package:flutter/material.dart';
import 'package:internet_shop/presentation/app.dart';
import 'package:internet_shop/services/products/products_service.dart';

import 'components/product_item.dart';

class ProductGridPage extends StatefulWidget {
  const ProductGridPage({super.key, required this.title, required this.categoryId});

  final String title;
  final int categoryId;

  @override
  State<ProductGridPage> createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {

  late final ProductsService _productsService;
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollContainer = ScrollController();

  @override
  void initState() {
    super.initState();
    _productsService = App().productsService;
    _scrollContainer.addListener(_scrollListener);
    _loadProducts();
  }

  @override
  void dispose() {
    _scrollContainer.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollContainer.position.pixels == _scrollContainer.position.maxScrollExtent) {
      _loadProducts();
    }
  }

  Future<void> _loadProducts() async {
    if (_isLoading || !_hasMore) return;

    final currentLength = _productsService.products.length;
    bool isProductsEmpty = _productsService.products.isEmpty;
    setState(() {if (isProductsEmpty) {
      _isLoading = true;
    }});
    await _productsService.fetchProducts(
        widget.categoryId,
        currentLength
    );
    setState(() {
      _isLoading = false;
      _hasMore = _productsService.products.length > currentLength;
      if (_productsService.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Durations.extralong2,
                content: Text("Something went wrong")
            )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (bool didPop, Object? result) => {
          if (didPop) _productsService.clearData()
        },
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .inversePrimary,
              title: Text(widget.title)
          ),
          body: _buildBody(),
        )
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final length = _productsService.products.length;
    return ListView.separated(
      controller: _scrollContainer,
      padding: const EdgeInsets.symmetric(
          vertical: _verticalPadding,
          horizontal: _horizontalPadding
      ),
      itemCount: length + (_hasMore ? 1 : 0),
      separatorBuilder: (context, index) => const SizedBox(
          height: _separatorHeight
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index >= _productsService.products.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(_loaderPadding),
              child: CircularProgressIndicator()
            )
          );
        }
        final product = _productsService.products[index];
        return productItem(context, product, index >= length - 1);
      },
    );
  }
}

const double _separatorHeight = 16;
const double _verticalPadding = 20;
const double _horizontalPadding = 12;
const double _loaderPadding = 8.0;
