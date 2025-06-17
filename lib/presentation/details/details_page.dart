

import 'package:flutter/material.dart';
import 'package:internet_shop/di/extensions.dart';
import 'package:internet_shop/presentation/details/components/product_item.dart';
import 'package:internet_shop/presentation/theme/extensions.dart';
import 'package:internet_shop/services/products/details_service.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final int productId;
  final String title;

  const DetailsPage({
    super.key, required this.productId, required this.title
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => context.provider.detailsService,
      child: _DetailsPageState(
        productId: productId,
        title: title,
      ),
    );
  }
}

class _DetailsPageState extends StatefulWidget {
  final int productId;
  final String title;

  const _DetailsPageState({
    required this.productId, required this.title
  });

  @override
  State<StatefulWidget> createState() => _DetailsPageContent();
}

class _DetailsPageContent extends State<_DetailsPageState> {

  bool _isLoading = false;
  String? _error;
  final ScrollController _scrollContainer = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDetails(widget.productId);
    });
  }

  @override
  void dispose() {
    _scrollContainer.dispose();
    super.dispose();
  }

  Future<void> _loadDetails(int productId) async {
    setState(() => _isLoading = true);
    final detailsService = context.read<DetailsService>();
    await detailsService.fetchProductDetails(productId);
    setState(() {
      _isLoading = false;
      final error = context.read<DetailsService>().error;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _buildBody(),
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
    final product = context.select(
        (DetailsService service) => service.product
    );
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
