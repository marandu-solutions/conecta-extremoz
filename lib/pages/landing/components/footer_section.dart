import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      color: AppTheme.secondaryColor,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? MediaQuery.of(context).size.width * 0.1 : 24,
        vertical: 64,
      ),
      child: Column(
        children: [
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2, child: _buildBrand(context)),
                Expanded(child: _buildLinks(context, 'Plataforma', ['Início', 'Vagas', 'Empresas', 'Sobre'])),
                Expanded(child: _buildLinks(context, 'Legal', ['Termos de Uso', 'Privacidade', 'LGPD'])),
                Expanded(child: _buildContact(context)),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrand(context),
                const SizedBox(height: 40),
                _buildLinks(context, 'Plataforma', ['Início', 'Vagas', 'Empresas', 'Sobre']),
                const SizedBox(height: 32),
                _buildLinks(context, 'Legal', ['Termos de Uso', 'Privacidade', 'LGPD']),
                const SizedBox(height: 32),
                _buildContact(context),
              ],
            ),
          const SizedBox(height: 64),
          const Divider(color: Colors.white24),
          const SizedBox(height: 24),
          Text(
            '© ${2024} Prefeitura Municipal de Extremoz. Todos os direitos reservados.',
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBrand(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.work_outline, color: AppTheme.secondaryColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              'CONECTA',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Cadastro Online de Empregabilidade e Contratação de Trabalhadores e Agências.',
          style: TextStyle(color: Colors.white70, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildLinks(BuildContext context, String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: () {},
                child: Text(
                  link,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildContact(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contato',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'contato@conecta.extremoz.rn.gov.br',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 12),
        const Text(
          '(84) 3000-0000',
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
