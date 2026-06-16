import 'package:flutter/material.dart';
import 'package:gymoraly/views/home_view.dart';
import 'package:gymoraly/views/progress_view.dart';
import 'package:gymoraly/views/community_view.dart';
import 'package:gymoraly/views/nutrition_view.dart';
import 'package:gymoraly/views/profissionais_view.dart';

class MainWrapperPage extends StatefulWidget {
  final String userName;
  const MainWrapperPage({super.key, required this.userName});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeView(userName: widget.userName),
      const ProgressView(),
      const CommunityView(),
      const NutritionView(),
      const ProfissionaisView(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2196F3),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Treinos'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progresso'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Comunidade'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Nutrição'),
          BottomNavigationBarItem(icon: Icon(Icons.badge), label: 'Pro'),
        ],
      ),
    );
  }
}
