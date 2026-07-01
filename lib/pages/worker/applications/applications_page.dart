import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/application_model.dart';

import 'components/application_filter_bar.dart';
import 'components/application_list_item.dart';
import 'components/application_timeline_view.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  final List<ApplicationModel> _allApplications = ApplicationModel.mockApplications();
  List<ApplicationModel> _filteredApplications = [];
  
  ApplicationStep? _activeFilter;
  ApplicationModel? _selectedApplication;

  @override
  void initState() {
    super.initState();
    _filteredApplications = _allApplications;
    if (_filteredApplications.isNotEmpty) {
      _selectedApplication = _filteredApplications.first;
    }
  }

  void _onFilterChanged(ApplicationStep? step) {
    setState(() {
      _activeFilter = step;
      if (step == null) {
        _filteredApplications = _allApplications;
      } else {
        _filteredApplications = _allApplications.where((app) => app.currentStep == step).toList();
      }
      
      // Reselecionar o primeiro da nova lista no Desktop
      if (_filteredApplications.isNotEmpty) {
        _selectedApplication = _filteredApplications.first;
      } else {
        _selectedApplication = null;
      }
    });
  }

  void _openTimelineMobile(ApplicationModel application) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ApplicationTimelineView(application: application),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: Padding(
        padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Minhas Candidaturas',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
            ).animate().fade().slideY(begin: -0.1),
            const SizedBox(height: 24),
            
            ApplicationFilterBar(
              activeFilter: _activeFilter,
              onFilterChanged: _onFilterChanged,
            ).animate().fade(delay: 100.ms).slideY(begin: -0.1),
            const SizedBox(height: 32),
            
            Expanded(
              child: _filteredApplications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox_outlined, size: 64, color: AppTheme.textSecondary.withOpacity(0.5)),
                          const SizedBox(height: 16),
                          const Text(
                            'Nenhuma candidatura encontrada.',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
                          ),
                        ],
                      ).animate().fade(),
                    )
                  : isDesktop
                      ? _buildDesktopLayout()
                      : _buildMobileLayout(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lista
        Expanded(
          flex: 1,
          child: ListView.separated(
            itemCount: _filteredApplications.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final app = _filteredApplications[index];
              final isSelected = _selectedApplication?.id == app.id;
              
              return ApplicationListItem(
                application: app,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedApplication = app;
                  });
                },
              ).animate().fade(delay: Duration(milliseconds: 200 + (index * 100))).slideX(begin: -0.1);
            },
          ),
        ),
        const SizedBox(width: 40),
        
        // Detalhes / Timeline
        Expanded(
          flex: 2,
          child: _selectedApplication != null
              ? ApplicationTimelineView(
                  key: ValueKey(_selectedApplication!.id),
                  application: _selectedApplication!,
                ).animate().fade().scale(begin: const Offset(0.98, 0.98))
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return ListView.separated(
      itemCount: _filteredApplications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final app = _filteredApplications[index];
        return ApplicationListItem(
          application: app,
          isSelected: false,
          onTap: () => _openTimelineMobile(app),
        ).animate().fade(delay: Duration(milliseconds: 200 + (index * 100))).slideY(begin: 0.1);
      },
    );
  }
}
