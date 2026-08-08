import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/pages/Auth/login/login_page.dart';

void main() {
  runApp(const ConectaApp());
}

class ConectaApp extends StatelessWidget {
  const ConectaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CONECTA - Prefeitura de Extremoz',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
