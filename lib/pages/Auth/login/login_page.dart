import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'components/login_hero.dart';
import 'components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Row(
        children: [
          if (isDesktop)
            const Expanded(
              child: LoginHero(),
            ),
          Expanded(
            child: LoginForm(isDesktop: isDesktop),
          ),
        ],
      ),
    );
  }
}
