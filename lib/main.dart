import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internet_shop/presentation/theme/theme.dart';
import 'package:internet_shop/src/generated/i18n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'di/app.dart';
import 'presentation/categories/category_grid_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //debugRepaintRainbowEnabled = true;
  await loadVariables();
  final app = App();
  await app.databaseHelper.initDatabase();
  runApp(
    Provider<App>.value(
      value: app,
      child: const StartWidget(),
    )
  );
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: myThemeLight,
      darkTheme: myThemeDark,
      home: const CategoryGridPage(),
    );
  }
}
