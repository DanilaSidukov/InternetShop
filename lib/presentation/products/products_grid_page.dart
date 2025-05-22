
import 'package:flutter/material.dart';
import 'package:internet_shop/presentation/app.dart';
import 'package:internet_shop/presentation/details/details_page.dart';
import 'package:internet_shop/services/products/products_service.dart';

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
    return ListView.separated(
      controller: _scrollContainer,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      itemCount: _productsService.products.length + (_hasMore ? 1 : 0),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (BuildContext context, int index) {
        if (index >= _productsService.products.length) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ));
        }
        final product = _productsService.products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      productId: product.productId,
                      title: product.title,
                    )
                )
            );
          },
          child: Card(
            child: Column(
              children: [
                if (product.imageUrl != null)
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "${product.price} руб",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
                  ),
                )
              ],
            ),
          )
        );
      },
    );
  }
}