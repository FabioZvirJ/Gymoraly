import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'features/auth/presentation/pages/login_page.dart';
import 'controllers/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuta as mudanças do themeController
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, child) {
        return MaterialApp(
          title: 'Gymoraly',
          themeMode: themeController.themeMode, // Define se é claro ou escuro dinamicamente
          
          // --- CONFIGURAÇÃO DO TEMA CLARO ---
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF2196F3),
            scaffoldBackgroundColor: const Color(0xFFF8F9FA),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF2196F3),
            ),
          ),

          // --- CONFIGURAÇÃO DO TEMA ESCURO ---
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF42A5F5), // Azul um pouco mais claro
            scaffoldBackgroundColor: const Color(0xFF121212), // Fundo escuro (não preto)
            cardColor: const Color(0xFF1E1E1E), // Cor dos cards no modo escuro
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E1E1E),
            ),
          ),
          
          home: const LoginPage(),
        );
      },
    );
  }
}