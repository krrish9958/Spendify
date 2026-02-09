import 'package:flutter/material.dart';
import 'package:spendify/data/expense_data.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'data/expense_data.dart';

// void main() {
//   runApp(const ExpenseApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ExpenseData.loadExpenses();
  await ExpenseData.loadBudget();

  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spendify',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
