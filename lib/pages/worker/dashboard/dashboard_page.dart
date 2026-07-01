import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/dashboard_data.dart';

import 'components/welcome_header.dart';
import 'components/metrics_cards.dart';
import 'components/recommended_jobs.dart';
import 'components/recent_applications.dart';
import 'components/dashboard_alerts.dart';
import 'components/courses_banner.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final DashboardData _data;

  @override
  void initState() {
    super.initState();
    // Em um app real, buscaríamos da API. Aqui usamos o Mock criado.
    _data = DashboardData.mock();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0),
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WelcomeHeader(
          profile: _data.profile,
        ).animate().fade().slideY(begin: -0.1),
        const SizedBox(height: 32),

        DashboardAlerts(alerts: _data.alerts).animate().fade(delay: 100.ms),
        const SizedBox(height: 24),

        MetricsCards(
          metrics: _data.metrics,
        ).animate().fade(delay: 200.ms).slideY(begin: 0.1),
        const SizedBox(height: 40),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  RecommendedJobs(
                    jobs: _data.recommendedJobs,
                  ).animate().fade(delay: 300.ms).slideX(begin: -0.1),
                  const SizedBox(height: 40),
                  RecentApplications(
                    applications: _data.recentApplications,
                  ).animate().fade(delay: 400.ms).slideX(begin: -0.1),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 1,
              child: CoursesBanner(
                courses: _data.recommendedCourses,
              ).animate().fade(delay: 500.ms).slideX(begin: 0.1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WelcomeHeader(
          profile: _data.profile,
        ).animate().fade().slideY(begin: -0.1),
        const SizedBox(height: 24),

        DashboardAlerts(alerts: _data.alerts).animate().fade(delay: 100.ms),

        MetricsCards(
          metrics: _data.metrics,
        ).animate().fade(delay: 200.ms).slideY(begin: 0.1),
        const SizedBox(height: 32),

        RecommendedJobs(
          jobs: _data.recommendedJobs,
        ).animate().fade(delay: 300.ms).slideX(begin: -0.1),
        const SizedBox(height: 32),

        RecentApplications(
          applications: _data.recentApplications,
        ).animate().fade(delay: 400.ms).slideX(begin: -0.1),
        const SizedBox(height: 32),

        CoursesBanner(
          courses: _data.recommendedCourses,
        ).animate().fade(delay: 500.ms).slideY(begin: 0.1),
        const SizedBox(height: 40),
      ],
    );
  }
}
