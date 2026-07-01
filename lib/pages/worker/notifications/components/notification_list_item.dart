import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/notification_model.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationListItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    IconData icon;
    Color bgColor;

    switch (notification.type) {
      case NotificationType.alert:
        iconColor = Colors.orange;
        icon = Icons.warning_amber_rounded;
        bgColor = Colors.orange.withOpacity(0.1);
        break;
      case NotificationType.message:
        iconColor = Colors.green;
        icon = Icons.mail_outline;
        bgColor = Colors.green.withOpacity(0.1);
        break;
      case NotificationType.job:
        iconColor = AppTheme.primaryColor;
        icon = Icons.work_outline;
        bgColor = AppTheme.primaryColor.withOpacity(0.1);
        break;
      case NotificationType.system:
        iconColor = Colors.blue;
        icon = Icons.info_outline;
        bgColor = Colors.blue.withOpacity(0.1);
        break;
    }

    if (notification.isRead) {
      bgColor = Colors.grey.withOpacity(0.05);
      iconColor = Colors.grey;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : AppTheme.primaryColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: notification.isRead ? Colors.grey.withOpacity(0.2) : AppTheme.primaryColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                            fontSize: 16,
                            color: notification.isRead ? AppTheme.textSecondary : AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        notification.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.content,
                    style: TextStyle(
                      color: notification.isRead ? AppTheme.textSecondary : AppTheme.textPrimary.withOpacity(0.8),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (!notification.isRead) ...[
              const SizedBox(width: 12),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
