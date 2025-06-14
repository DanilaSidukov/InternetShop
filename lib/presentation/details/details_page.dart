

import 'package:flutter/material.dart';
import 'package:internet_shop/di/extensions.dart';
import 'package:internet_shop/presentation/details/components/product_item.dart';
import 'package:internet_shop/presentation/theme/extensions.dart';

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

  bool _isLoading = false;
  String? _error;
  final ScrollController _scrollContainer = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadDetails(widget.productId);
  }

  @override
  void dispose() {
    _scrollContainer.dispose();
    super.dispose();
  }

  Future<void> _loadDetails(int productId) async {
    setState(() => _isLoading = true);
    final detailsService = context.provider.detailsService;
    await detailsService.fetchProductDetails(productId);
    setState(() {
      _isLoading = false;
      _error = detailsService.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailsService = context.provider.detailsService;
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) => {
        if (didPop) detailsService.clearData()
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
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
      return Center(child: Text(
          context.strings.error(_error!)
      ));
    }
    final detailsService = context.provider.detailsService;
    final product = detailsService.product;
    return ListView(
      controller: _scrollContainer,
      padding: EdgeInsets.only(
        left: _listHorizontalPadding, right: _listHorizontalPadding,
        bottom: MediaQuery.of(context).padding.bottom
      ),
      children: productDetailsItems(context, product)
    );
  }
}

final double _listHorizontalPadding = 20;
