import 'package:flutter/material.dart';
import 'package:spendify/features/report/report_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../expense/add_expense_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    AddExpenseScreen(),
    HistoryScreen(),
    ReportScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          _screens[_currentIndex],

          // Floating bottom navigation
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _buildFloatingNav(),
          ),
        ],
      ),
    );
  }

  // Floating nav container
  Widget _buildFloatingNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home, 0),
          _navItem(Icons.add, 1, isCenter: true),
          _navItem(Icons.history, 2),
          _navItem(Icons.bar_chart, 3),
          _navItem(Icons.person, 4),
        ],
      ),
    );
  }

  // Individual nav item
  Widget _navItem(IconData icon, int index, {bool isCenter = false}) {
    final bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: isCenter
            ? BoxDecoration(
                color: isActive
                    ? const Color(0xFF7E57C2)
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              )
            : null,

        child: Icon(
          icon,
          size: isCenter ? 28 : 24,
          color: isCenter
              ? (isActive ? Colors.white : Colors.grey)
              : isActive
              ? const Color(0xFF7E57C2)
              : Colors.grey,
        ),
      ),
    );
  }
}
