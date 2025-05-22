import 'package:flutter/material.dart';
import 'package:internet_shop/presentation/app.dart';
import 'package:internet_shop/presentation/products/products_grid_page.dart';
import 'package:internet_shop/services/categories/categories_service.dart';

class CategoryGridPage extends StatefulWidget {
  const CategoryGridPage({super.key, required this.title});

  final String title;

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
    _catalogService = App().catalogDataService;
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
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: _catalogService.categories.length,
      itemBuilder: (context, index) {
        final category = _catalogService.categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductGridPage(
                        title: "Products",
                        categoryId: category.categoryId
                    )
                )
            );
          },
          child: Card(
            child: Column(
              children: [
                if (category.imageUrl != null)
                  Expanded(
                    child: Image.network(
                      category.imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    category.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
