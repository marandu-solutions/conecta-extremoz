import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';

class LoginHero extends StatelessWidget {
  const LoginHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Stack(
        children: [
          // Imagem de fundo com overlay escuro
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1497215728101-856f4ea42174?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
              fit: BoxFit.cover,
              color: AppTheme.primaryDark.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.work_outline, size: 48, color: AppTheme.primaryColor),
                  ).animate().fade().scale(),
                  const SizedBox(height: 32),
                  Text(
                    'Bem-vindo de volta ao\nCONECTA',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ).animate().fade(delay: 200.ms).slideX(begin: -0.1),
                  const SizedBox(height: 16),
                  Text(
                    'Acesse sua conta para continuar buscando as melhores oportunidades ou os melhores talentos para sua empresa.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ).animate().fade(delay: 400.ms).slideX(begin: -0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
