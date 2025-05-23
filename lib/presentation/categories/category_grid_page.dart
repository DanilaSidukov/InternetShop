import 'package:flutter/material.dart';
import 'package:internet_shop/presentation/app.dart';
import 'package:internet_shop/presentation/extensions.dart';
import 'package:internet_shop/services/categories/categories_service.dart';

import 'components/category_item.dart';

class CategoryGridPage extends StatefulWidget {
  const CategoryGridPage({super.key});

  @override
  State<CategoryGridPage> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<CategoryGridPage> {
  late final CategoriesService _catalogService;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _catalogService = App().categoriesService;
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    await _catalogService.fetchCategories();
    setState(() {
      _isLoading = false;
      _error = _catalogService.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.strings.catalog),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(context.strings.error(_error!)));
    }

    final length = _catalogService.categories.length;

    return GridView.builder(
      padding: const EdgeInsets.all(_screenPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridLength,
        crossAxisSpacing: _cellPadding,
        mainAxisSpacing: _cellPadding,
        childAspectRatio: _cellRation,
      ),
      itemCount: length,
      itemBuilder: (context, index) {
        final category = _catalogService.categories[index];
        return buildCategoryItem(context, category);
      },
    );
  }
}

const int _gridLength = 2;
const double _cellPadding = 10;
const double _cellRation = 1.0;
const double _screenPadding = 16;
