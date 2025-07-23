
import 'package:flutter/material.dart';
import 'package:internet_shop/di/extensions.dart';
import 'package:internet_shop/presentation/products/products_service.dart';
import 'package:internet_shop/presentation/theme/extensions.dart';
import 'package:provider/provider.dart';

import 'components/product_item.dart';

class ProductGridPage extends StatelessWidget {
  final int categoryId;

  const ProductGridPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => context.provider.productsService,
      child: _ProductGridPageState(categoryId: categoryId)
    );
  }
}

class _ProductGridPageState extends StatefulWidget {
  final int categoryId;

  const _ProductGridPageState({required this.categoryId});

  @override
  State<StatefulWidget> createState() => _ProductGridPageContent();
}

class _ProductGridPageContent extends State<_ProductGridPageState> {

  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollContainer = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollContainer.addListener(_scrollListener);
      _loadProducts();
    });
  }

  @override
  void dispose() {
    _scrollContainer.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final position = _scrollContainer.position;
    if (position.pixels == position.maxScrollExtent) {
      _loadProducts();
    }
  }

  Future<void> _loadProducts() async {
    if (_isLoading || !_hasMore) return;

    final productsService = context.read<ProductsService>();

    final currentLength = productsService.products.length;
    bool isProductsEmpty = productsService.products.isEmpty;
    setState(() {
      if (isProductsEmpty) {
        _isLoading = true;
      }
    });
    await productsService.fetchProducts(
        widget.categoryId,
        currentLength
    );
    setState(() {
      _isLoading = false;
      final productsLength = context.read<ProductsService>().products.length;
      _hasMore = productsLength > currentLength;
      if (productsService.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Durations.extralong2,
                content: Text(context.strings.something_went_wrong)
            )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(context.strings.products)
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final products = context.select(
        (ProductsService service) => service.products
    );
    final length = products.length;
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
        if (index >= products.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(_loaderPadding),
              child: CircularProgressIndicator()
            )
          );
        }
        final product = products[index];
        return ProductItem(product, index >= length - 1);
      },
    );
  }
}

const double _separatorHeight = 16;
const double _verticalPadding = 20;
const double _horizontalPadding = 12;
const double _loaderPadding = 8.0;
