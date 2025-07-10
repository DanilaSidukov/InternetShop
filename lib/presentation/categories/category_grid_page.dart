import 'package:flutter/material.dart';
import 'package:internet_shop/domain/di/app.dart';
import 'package:internet_shop/domain/di/extensions.dart';
import 'package:internet_shop/presentation/categories/categories_service.dart';
import 'package:internet_shop/presentation/theme/extensions.dart';
import 'package:provider/provider.dart';

import 'components/category_item.dart';

class CategoryGridPage extends StatelessWidget {

  const CategoryGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => context.provider.categoriesService,
      child: const _CategoryGridPageContent(),
    );
  }
}

class _CategoryGridPageContent extends StatefulWidget {
  const _CategoryGridPageContent();

  @override
  State<_CategoryGridPageContent> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<_CategoryGridPageContent> {
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
    await context.read<CategoriesService>().fetchCategories();
    setState(() {
      _isLoading = false;
      final error = context.read<CategoriesService>().error;
      _error = error;
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
    final categories = context.select(
        (CategoriesService service) => service.categories
    );
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(context.strings.error(_error!)));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(_screenPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridLength,
        crossAxisSpacing: _cellPadding,
        mainAxisSpacing: _cellPadding,
        childAspectRatio: _cellRation,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryItem(category);
      },
    );
  }
}

const int _gridLength = 2;
const double _cellPadding = 10;
const double _cellRation = 1.0;
const double _screenPadding = 16;
