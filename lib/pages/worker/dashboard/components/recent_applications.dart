import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/dashboard_data.dart';

class RecentApplications extends StatelessWidget {
  final List<ApplicationStatus> applications;

  const RecentApplications({super.key, required this.applications});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Minhas Candidaturas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Histórico completo'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...applications.map((app) => _buildApplicationItem(app)),
        ],
      ),
    );
  }

  Widget _buildApplicationItem(ApplicationStatus app) {
    Color statusColor;
    IconData statusIcon;

    switch (app.status) {
      case ApplicationState.sent:
        statusColor = Colors.blue;
        statusIcon = Icons.send_outlined;
        break;
      case ApplicationState.inAnalysis:
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty;
        break;
      case ApplicationState.interview:
        statusColor = Colors.green;
        statusIcon = Icons.event_available;
        break;
      case ApplicationState.rejected:
        statusColor = Colors.red;
        statusIcon = Icons.close;
        break;
      case ApplicationState.hired:
        statusColor = AppTheme.primaryColor;
        statusIcon = Icons.star;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.jobTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  app.company,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        app.statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (app.status == ApplicationState.interview) ...[
                        const SizedBox(width: 8),
                        Text(
                          app.date,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
