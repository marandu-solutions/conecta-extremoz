import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'components/register_hero.dart';
import 'components/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
              child: RegisterHero(),
            ),
          Expanded(
            child: RegisterForm(isDesktop: isDesktop),
          ),
        ],
      ),
    );
  }
}