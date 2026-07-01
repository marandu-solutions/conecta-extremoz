import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? size.width * 0.1 : 24,
        vertical: isDesktop ? 80 : 40,
      ),
      child: isDesktop
          ? Row(
              children: [
                Expanded(child: _buildTextContent(context)),
                const SizedBox(width: 40),
                Expanded(child: _buildImageContent()),
              ],
            )
          : Column(
              children: [
                _buildTextContent(context),
                const SizedBox(height: 40),
                _buildImageContent(),
              ],
            ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Prefeitura Municipal de Extremoz',
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ).animate().fade().slideY(begin: -0.2),
        const SizedBox(height: 24),
        Text(
          'Conectando Talentos às Melhores Oportunidades',
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(color: AppTheme.textPrimary),
        ).animate().fade(delay: 200.ms).slideY(begin: 0.1),
        const SizedBox(height: 24),
        Text(
          'O CONECTA é a plataforma oficial de empregabilidade e contratação. '
          'Encontre a vaga ideal para o seu perfil ou o candidato perfeito para a sua empresa de forma rápida e segura.',
          style: Theme.of(context).textTheme.bodyLarge,
        ).animate().fade(delay: 400.ms).slideY(begin: 0.1),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person_search_rounded),
              label: const Text('Sou Trabalhador'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.business_center_rounded),
              label: const Text('Sou Empresa'),
            ),
          ],
        ).animate().fade(delay: 600.ms).slideY(begin: 0.1),
      ],
    );
  }

  Widget _buildImageContent() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.network(
          'https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryColor),
              ),
            );
          },
        ),
      ),
    ).animate().fade(delay: 300.ms).scale(begin: const Offset(0.9, 0.9));
  }
}
