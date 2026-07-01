import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? MediaQuery.of(context).size.width * 0.1 : 24,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'Como o CONECTA funciona?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ).animate().fade().slideY(begin: 0.2),
          const SizedBox(height: 16),
          Text(
            'Um processo simples e direto para facilitar a sua vida.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ).animate().fade(delay: 200.ms).slideY(begin: 0.2),
          const SizedBox(height: 64),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              _FeatureCard(
                icon: Icons.app_registration_rounded,
                title: 'Cadastre-se',
                description:
                    'Crie seu perfil gratuitamente informando seus dados, habilidades e experiências.',
                delay: 0,
              ),
              _FeatureCard(
                icon: Icons.search_rounded,
                title: 'Encontre Vagas',
                description:
                    'Explore oportunidades que combinam perfeitamente com o seu perfil profissional.',
                delay: 200,
              ),
              _FeatureCard(
                icon: Icons.handshake_rounded,
                title: 'Conecte-se',
                description:
                    'Empresas avaliam seu perfil e entram em contato direto para entrevistas.',
                delay: 400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final int delay;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 40, color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    ).animate().fade(delay: delay.ms).scale(begin: const Offset(0.9, 0.9));
  }
}
