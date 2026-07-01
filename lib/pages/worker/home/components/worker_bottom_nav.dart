import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:conecta/theme/app_theme.dart';

class WorkerBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const WorkerBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: AppTheme.primaryColor,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            color: AppTheme.textSecondary,
            tabs: const [
              GButton(
                icon: Icons.dashboard_outlined,
                text: 'Painel',
              ),
              GButton(
                icon: Icons.search_outlined,
                text: 'Vagas',
              ),
              GButton(
                icon: Icons.work_history_outlined,
                text: 'Aplicações',
              ),
              GButton(
                icon: Icons.school_outlined,
                text: 'Cursos',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Perfil',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
