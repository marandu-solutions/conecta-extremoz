import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';

class ResumeSectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final VoidCallback? onEdit;
  final bool isCompleted;

  const ResumeSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.onEdit,
    this.isCompleted = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.orange.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header da Seção
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppTheme.surfaceColor
                  : Colors.orange.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              border: Border(
                bottom: BorderSide(
                  color: isCompleted
                      ? AppTheme.primaryColor.withOpacity(0.05)
                      : Colors.orange.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppTheme.primaryColor.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: isCompleted ? AppTheme.primaryColor : Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? AppTheme.textPrimary : Colors.orange.shade800,
                    ),
                  ),
                ),
                if (!isCompleted)
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Pendente',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    color: AppTheme.primaryColor,
                    onPressed: onEdit,
                    tooltip: 'Editar $title',
                  ),
              ],
            ),
          ),
          // Corpo da Seção
          Padding(
            padding: const EdgeInsets.all(24),
            child: child,
          ),
        ],
      ),
    );
  }
}

class ResumeFieldViewer extends StatelessWidget {
  final String label;
  final String value;
  final bool isFullWidth;

  const ResumeFieldViewer({
    super.key,
    required this.label,
    required this.value,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.isEmpty ? 'Não informado' : value,
          style: TextStyle(
            fontSize: 15,
            color: value.isEmpty ? AppTheme.textSecondary.withOpacity(0.5) : AppTheme.textPrimary,
            fontWeight: value.isEmpty ? FontWeight.normal : FontWeight.w500,
          ),
        ),
      ],
    );

    if (isFullWidth) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: content,
      );
    }

    return content;
  }
}
