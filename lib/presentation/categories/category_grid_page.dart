import 'package:flutter/material.dart';
import 'package:internet_shop/di/app.dart';
import 'package:internet_shop/di/extensions.dart';
import 'package:internet_shop/presentation/theme/extensions.dart';
import 'package:provider/provider.dart';

import 'components/category_item.dart';

class CategoryGridPage extends StatefulWidget {
  const CategoryGridPage({super.key});

  @override
  State<CategoryGridPage> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<CategoryGridPage> {
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategories();
    });
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    final catalogService = context.provider.categoriesService;
    await catalogService.fetchCategories();
    setState(() {
      _isLoading = false;
      _error = catalogService.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<App>(
      create: (context) => App(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(context.strings.catalog),
          ),
          body: _buildBody(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    final catalogService = context.provider.categoriesService;
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(context.strings.error(_error!)));
    }

    final length = catalogService.categories.length;

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
        final category = catalogService.categories[index];
        return CategoryItem(category);
      },
    );
  }
}

const int _gridLength = 2;
const double _cellPadding = 10;
const double _cellRation = 1.0;
const double _screenPadding = 16;
