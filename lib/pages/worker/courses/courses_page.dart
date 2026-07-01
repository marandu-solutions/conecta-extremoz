import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/course_model.dart';

import 'components/courses_header.dart';
import 'components/course_card.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<CourseModel> _courses = CourseModel.mockCourses();
  final List<EmployabilityTip> _tips = EmployabilityTip.mockTips();

  Timer? _tipTimer;
  EmployabilityTip? _currentTip;
  bool _showTip = false;
  int _tipIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTipCycle();
  }

  void _startTipCycle() {
    // Mostra a primeira dica após 2 segundos do carregamento da tela
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _showNextTip();
    });

    // Configura o ciclo para mostrar uma nova dica a cada 15 segundos
    _tipTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (mounted) _showNextTip();
    });
  }

  void _showNextTip() {
    setState(() {
      _currentTip = _tips[_tipIndex];
      _showTip = true;
      _tipIndex = (_tipIndex + 1) % _tips.length;
    });

    // Esconde a dica após 6 segundos visível na tela
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          _showTip = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tipTimer?.cancel();
    super.dispose();
  }

  void _showEnrollmentDialog(CourseModel course) {
    if (!course.isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inscrições esgotadas para este curso no momento.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Inscrição'),
        content: Text('Deseja se inscrever no curso "${course.title}" oferecido por ${course.provider}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Inscrição realizada com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: Stack(
        children: [
          // Conteúdo Principal
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CoursesHeader().animate().fade().slideY(begin: -0.1),
                  const SizedBox(height: 40),
                  
                  const Text(
                    'Cursos em Destaque',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ).animate().fade(delay: 100.ms),
                  const SizedBox(height: 20),
                  
                  // Grid super responsivo (adapta para 1, 2, 3 ou 4 colunas automaticamente)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(
                        course: _courses[index],
                        onTap: () => _showEnrollmentDialog(_courses[index]),
                      ).animate().fade(delay: Duration(milliseconds: 200 + (index * 100))).slideY(begin: 0.1);
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // Dica de Empregabilidade Flutuante (Estilo "Game Tooltip")
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            bottom: _showTip ? (isDesktop ? 40 : 24) : -150,
            right: isDesktop ? 40 : 24,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: _showTip ? 1.0 : 0.0,
              child: Container(
                width: isDesktop ? 350 : MediaQuery.of(context).size.width - 48,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryDark,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb, color: Colors.amber, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentTip?.title ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _currentTip?.summary ?? '',
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70, size: 18),
                      onPressed: () {
                        setState(() {
                          _showTip = false;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
