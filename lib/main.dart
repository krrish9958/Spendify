import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendify/widgets/app_card.dart';

import 'features/home/home_screen.dart';
import 'core/theme/theme_provider.dart';
import 'data/expense_data.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ExpenseData.loadExpenses();
  await ThemeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
      ),

      home: const HomeScreen(),
    );
  }
}
