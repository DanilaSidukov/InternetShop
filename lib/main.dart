import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'presentation/categories/category_grid_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadVariables();
  runApp(const StartWidget());
}

Future loadVariables() async {
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
}

class StartWidget extends StatelessWidget {

  const StartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internet Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CategoryGridPage(title: 'Catalog'),
    );
  }
}
