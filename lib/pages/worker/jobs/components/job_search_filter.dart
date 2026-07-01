import 'package:flutter/material.dart';
import 'package:conecta/theme/app_theme.dart';

class JobSearchFilter extends StatelessWidget {
  final List<String> activeFilters;
  final Function(String) onFilterToggle;

  const JobSearchFilter({
    super.key,
    required this.activeFilters,
    required this.onFilterToggle,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      'Presencial',
      'Híbrido',
      'Home Office',
      'CLT',
      'Estágio',
      'Sem Experiência'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar por cargo, empresa ou palavra-chave...',
                  prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(0.1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.tune, color: Colors.white),
                onPressed: () {},
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final filter = filters[index];
              final isActive = activeFilters.contains(filter);

              return ActionChip(
                label: Text(
                  filter,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppTheme.textSecondary,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                backgroundColor: isActive ? AppTheme.primaryColor : Colors.white,
                side: BorderSide(
                  color: isActive ? AppTheme.primaryColor : AppTheme.textSecondary.withOpacity(0.2),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () => onFilterToggle(filter),
              );
            },
          ),
        ),
      ],
    );
  }
}
