import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/job_model.dart';

import 'components/job_search_filter.dart';
import 'components/job_list_item.dart';
import 'components/job_details_view.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  final List<JobModel> _jobs = JobModel.mockJobs();
  final List<String> _activeFilters = [];
  JobModel? _selectedJob;

  @override
  void initState() {
    super.initState();
    // Seleciona a primeira vaga por padrão no desktop
    if (_jobs.isNotEmpty) {
      _selectedJob = _jobs.first;
    }
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_activeFilters.contains(filter)) {
        _activeFilters.remove(filter);
      } else {
        _activeFilters.add(filter);
      }
    });
  }

  void _toggleSaveJob(JobModel job) {
    setState(() {
      job.isSaved = !job.isSaved;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          job.isSaved
              ? 'Vaga salva nos favoritos!'
              : 'Vaga removida dos favoritos.',
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: job.isSaved ? Colors.green : Colors.orange,
      ),
    );
  }

  void _applyToJob(JobModel job) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Currículo enviado com sucesso para ${job.company}!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _openJobDetailsMobile(JobModel job) {
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
                child: JobDetailsView(
                  job: job,
                  onApply: () {
                    Navigator.pop(context);
                    _applyToJob(job);
                  },
                  onSave: () => _toggleSaveJob(job),
                ),
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
              'Mural de Vagas',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ).animate().fade().slideY(begin: -0.1),
            const SizedBox(height: 24),

            JobSearchFilter(
              activeFilters: _activeFilters,
              onFilterToggle: _toggleFilter,
            ).animate().fade(delay: 100.ms).slideY(begin: -0.1),
            const SizedBox(height: 32),

            Expanded(
              child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
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
        // Lista de Vagas
        Expanded(
          flex: 1,
          child: ListView.separated(
            itemCount: _jobs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final job = _jobs[index];
              final isSelected = _selectedJob?.id == job.id;

              return JobListItem(
                    job: job,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedJob = job;
                      });
                    },
                    onToggleSave: () => _toggleSaveJob(job),
                  )
                  .animate()
                  .fade(delay: Duration(milliseconds: 200 + (index * 100)))
                  .slideX(begin: -0.1);
            },
          ),
        ),
        const SizedBox(width: 40),

        // Detalhes da Vaga
        Expanded(
          flex: 2,
          child: _selectedJob != null
              ? JobDetailsView(
                  key: ValueKey(_selectedJob!.id),
                  job: _selectedJob!,
                  onApply: () => _applyToJob(_selectedJob!),
                  onSave: () => _toggleSaveJob(_selectedJob!),
                ).animate().fade().scale(begin: const Offset(0.98, 0.98))
              : const Center(
                  child: Text('Selecione uma vaga para ver os detalhes'),
                ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return ListView.separated(
      itemCount: _jobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final job = _jobs[index];
        return JobListItem(
              job: job,
              isSelected: false,
              onTap: () => _openJobDetailsMobile(job),
              onToggleSave: () => _toggleSaveJob(job),
            )
            .animate()
            .fade(delay: Duration(milliseconds: 200 + (index * 100)))
            .slideY(begin: 0.1);
      },
    );
  }
}
