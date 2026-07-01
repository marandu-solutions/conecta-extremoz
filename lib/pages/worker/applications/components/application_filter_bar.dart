import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/application_model.dart';

class ApplicationFilterBar extends StatelessWidget {
  final ApplicationStep? activeFilter;
  final Function(ApplicationStep?) onFilterChanged;

  const ApplicationFilterBar({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('Todas', null),
          const SizedBox(width: 8),
          _buildFilterChip('Enviadas', ApplicationStep.sent),
          const SizedBox(width: 8),
          _buildFilterChip('Em Análise', ApplicationStep.review),
          const SizedBox(width: 8),
          _buildFilterChip('Entrevistas', ApplicationStep.interview),
          const SizedBox(width: 8),
          _buildFilterChip('Finalizadas', ApplicationStep.rejected),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, ApplicationStep? step) {
    final isSelected = activeFilter == step;

    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppTheme.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      backgroundColor: isSelected ? AppTheme.primaryColor : Colors.white,
      side: BorderSide(
        color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary.withOpacity(0.2),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () => onFilterChanged(step),
    );
  }
}
