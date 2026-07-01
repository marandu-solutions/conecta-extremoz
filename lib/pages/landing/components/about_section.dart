import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppTheme.lightGradient),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? MediaQuery.of(context).size.width * 0.1 : 24,
        vertical: 80,
      ),
      child: isDesktop
          ? Row(
              children: [
                Expanded(child: _buildImage()),
                const SizedBox(width: 64),
                Expanded(child: _buildText(context)),
              ],
            )
          : Column(
              children: [
                _buildImage(),
                const SizedBox(height: 40),
                _buildText(context),
              ],
            ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.network(
          'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
          fit: BoxFit.cover,
        ),
      ),
    ).animate().fade(duration: 600.ms).slideX(begin: -0.1);
  }

  Widget _buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sobre o Projeto',
          style: TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ).animate().fade().slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          'Desenvolvimento e Inovação para Extremoz',
          style: Theme.of(context).textTheme.headlineLarge,
        ).animate().fade(delay: 200.ms).slideY(begin: 0.2),
        const SizedBox(height: 24),
        Text(
          'A Prefeitura Municipal de Extremoz, através do CONECTA, busca fomentar a economia local unindo quem precisa trabalhar a quem precisa contratar. Nosso objetivo é modernizar o acesso ao mercado de trabalho, garantindo mais transparência, agilidade e oportunidades para todos os cidadãos.',
          style: Theme.of(context).textTheme.bodyLarge,
        ).animate().fade(delay: 400.ms).slideY(begin: 0.2),
        const SizedBox(height: 32),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Conheça a Prefeitura'),
        ).animate().fade(delay: 600.ms).slideY(begin: 0.2),
      ],
    );
  }
}
