import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';

class WorkerSideBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const WorkerSideBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          _buildLogo(context),
          const Divider(height: 1, color: Colors.black12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              children: [
                _buildNavItem(0, Icons.dashboard_outlined, 'Painel Inicial'),
                _buildNavItem(1, Icons.search_outlined, 'Mural de Vagas'),
                _buildNavItem(2, Icons.work_history_outlined, 'Minhas Candidaturas'),
                _buildNavItem(3, Icons.school_outlined, 'Qualificação e Cursos'),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  child: Text(
                    'CONTA',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                _buildNavItem(4, Icons.person_outline, 'Meu Currículo'),
                _buildNavItem(5, Icons.notifications_none_outlined, 'Notificações'),
                _buildNavItem(6, Icons.settings_outlined, 'Configurações'),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.black12),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.work_outline, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            'CONECTA',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String title) {
    final isSelected = selectedIndex == index;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => onTabChange(index),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/');
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: const [
            Icon(Icons.logout_outlined, color: Colors.redAccent),
            SizedBox(width: 16),
            Text(
              'Sair',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
