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
      child: _ProductGridPageState(categoryId: categoryId),
    );
  }
}

class _ProductGridPageState extends StatefulWidget {
  final int categoryId;

  const _ProductGridPageState({required this.categoryId});

  @override
  State<StatefulWidget> createState() => _ProductGridPageContent();
}

class _ProductGridPageContent extends State<_ProductGridPageState>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _hasMore = true;
  late AnimationController _loaderController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _loaderController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(_loaderController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProducts();
      _loaderController.value = 0.0;
    });
  }

  @override
  void dispose() {
    _loaderController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    if (_isLoading || !_hasMore) return;

    final productsService = context.read<ProductsService>();

    final currentLength = productsService.products.length;
    bool isProductsEmpty = productsService.products.isEmpty;
    setState(() {
      if (isProductsEmpty) {
        _isLoading = true;
      } else {
        _loaderController.forward();
      }
    });
    await productsService.fetchProducts(widget.categoryId, currentLength);
    setState(() {
      _isLoading = false;
      if (!isProductsEmpty) {
        _loaderController.reverse();
      }
      final productsLength = context.read<ProductsService>().products.length;
      _hasMore = productsLength > currentLength;
      if (productsService.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Durations.extralong2,
            content: Text(context.strings.something_went_wrong),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.strings.products),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final products = context.select(
      (ProductsService service) => service.products,
    );
    final length = products.length;
    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
      if (notification is ScrollEndNotification &&
          notification.metrics.extentAfter <= 400) {
        _loadProducts();
      }
      return false;
    },
    child: Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: _verticalPadding,
            horizontal: _horizontalPadding,
          ),
          itemCount: length,
          separatorBuilder:
              (context, index) => const SizedBox(height: _separatorHeight),
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];
            return ProductItem(product, index >= length - 1);
          },
        ),
        SlideTransition(
          position: _offsetAnimation,
          child: Padding(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(context).padding.bottom + _loaderBottomPadding,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: _loaderHeight,
                child: const Center(
                    child: CircularProgressIndicator()
                ),
              ),
            ),
          ),
        ),
      ],
    )
    );
  }
}

const double _separatorHeight = 16;
const double _verticalPadding = 20;
const double _horizontalPadding = 12;
const double _loaderBottomPadding = 30.0;
const double _loaderHeight = 40.0;
