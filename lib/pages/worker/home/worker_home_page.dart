import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';

import 'components/worker_side_bar.dart';
import 'components/worker_bottom_nav.dart';

// Módulos
import '../dashboard/dashboard_page.dart';
import '../jobs/jobs_page.dart';
import '../applications/applications_page.dart';
import '../courses/courses_page.dart';
import '../resume/resume_page.dart';
import '../notifications/notifications_page.dart';
import '../settings/settings_page.dart';

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({super.key});

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const JobsPage(),
    const ApplicationsPage(),
    const CoursesPage(),
    const ResumePage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      
      // AppBar visível apenas no mobile para acessar Notificações/Configurações rápidas
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  Icon(Icons.work_outline, color: AppTheme.primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'CONECTA',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined, color: AppTheme.textPrimary),
                  onPressed: () => _onTabChange(5), // Vai para Notificações
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined, color: AppTheme.textPrimary),
                  onPressed: () => _onTabChange(6), // Vai para Configurações
                ),
              ],
            ),

      body: Row(
        children: [
          if (isDesktop)
            WorkerSideBar(
              selectedIndex: _selectedIndex,
              onTabChange: _onTabChange,
            ).animate().fade().slideX(begin: -0.1),
            
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.05),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey<int>(_selectedIndex),
                child: _pages[_selectedIndex],
              ),
            ),
          ),
        ],
      ),

      // BottomNav apenas no Mobile e ignorando os índices de notificação/config (índices 5 e 6)
      bottomNavigationBar: isDesktop
          ? null
          : WorkerBottomNav(
              // Se estiver nas telas extras (5,6), mantemos o foco visual no painel ou removemos foco
              selectedIndex: _selectedIndex > 4 ? 0 : _selectedIndex,
              onTabChange: _onTabChange,
            ).animate().fade().slideY(begin: 0.2),
    );
  }
}
