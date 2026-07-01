import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/dashboard_data.dart';

class MetricsCards extends StatelessWidget {
  final DashboardMetrics metrics;

  const MetricsCards({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final crossAxisCount = isMobile ? 2 : 4;
        
        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: isMobile ? 1.5 : 1.2,
          children: [
            _buildMetricCard(
              context,
              title: 'Vagas\nDisponíveis',
              value: metrics.availableJobs.toString(),
              icon: Icons.work_outline,
              color: AppTheme.primaryColor,
            ),
            _buildMetricCard(
              context,
              title: 'Candidaturas\nEnviadas',
              value: metrics.applicationsSent.toString(),
              icon: Icons.send_outlined,
              color: Colors.purple,
            ),
            _buildMetricCard(
              context,
              title: 'Visualizações\ndo Currículo',
              value: metrics.profileViews.toString(),
              icon: Icons.visibility_outlined,
              color: Colors.orange,
            ),
            _buildMetricCard(
              context,
              title: 'Entrevistas\nAgendadas',
              value: metrics.scheduledInterviews.toString(),
              icon: Icons.event_available_outlined,
              color: Colors.green,
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard(BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
