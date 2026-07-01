import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/resume_model.dart';

import 'components/resume_header.dart';
import 'components/resume_section_card.dart';
import 'components/edit_personal_info_modal.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  ResumeModel _resume = ResumeModel.mock();

  void _showEditModal(String section) {
    if (section == 'Informações Pessoais') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => EditPersonalInfoModal(
          initialData: _resume.personalInfo,
          onSave: (newData) {
            setState(() {
              _resume.personalInfo = newData;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Informações Pessoais atualizadas com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      );
    } else {
      // Mock para as outras seções
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Modal de edição para "$section" será implementado em breve.'),
          backgroundColor: AppTheme.primaryColor,
        ),
      );
    }
  }

  void _generatePdf() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lendo template HTML e gerando PDF... (Simulação)'),
        backgroundColor: AppTheme.primaryDark,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppTheme.surfaceColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResumeHeader(
                  completionPercentage: 85,
                  onGeneratePdf: _generatePdf,
                ).animate().fade().slideY(begin: -0.1),
                const SizedBox(height: 32),

                // Seção 1: Informações Pessoais
                ResumeSectionCard(
                  title: 'Informações Pessoais e Inclusão',
                  icon: Icons.person_outline,
                  onEdit: () => _showEditModal('Informações Pessoais'),
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: 250,
                        child: ResumeFieldViewer(
                          label: 'Nome Completo',
                          value: _resume.personalInfo.fullName,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ResumeFieldViewer(
                          label: 'CPF',
                          value: _resume.personalInfo.cpf,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ResumeFieldViewer(
                          label: 'Data de Nascimento',
                          value: _resume.personalInfo.birthDate,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ResumeFieldViewer(
                          label: 'PCD',
                          value: _resume.personalInfo.isPcd
                              ? 'Sim (${_resume.personalInfo.pcdType})'
                              : 'Não',
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: ResumeFieldViewer(
                          label: 'Programas Sociais (CadÚnico)',
                          value: _resume.personalInfo.socialProgram
                              ? 'Inscrito'
                              : 'Não inscrito',
                        ),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 100.ms).slideX(begin: -0.05),

                // Seção 2: Contato e Localização
                ResumeSectionCard(
                  title: 'Contato e Localização',
                  icon: Icons.contact_mail_outlined,
                  onEdit: () => _showEditModal('Contato'),
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: 200,
                        child: ResumeFieldViewer(
                          label: 'WhatsApp / Telefone',
                          value: _resume.contactInfo.phone,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ResumeFieldViewer(
                          label: 'E-mail',
                          value: _resume.contactInfo.email,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: ResumeFieldViewer(
                          label: 'Endereço',
                          value: _resume.contactInfo.address,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ResumeFieldViewer(
                          label: 'Bairro / Distrito',
                          value: _resume.contactInfo.neighborhood,
                        ),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 200.ms).slideX(begin: -0.05),

                // Seção 3: Objetivo Profissional
                ResumeSectionCard(
                  title: 'Objetivo e Perfil Profissional',
                  icon: Icons.track_changes_outlined,
                  onEdit: () => _showEditModal('Objetivo'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 24,
                        runSpacing: 16,
                        children: [
                          SizedBox(
                            width: 250,
                            child: ResumeFieldViewer(
                              label: 'Cargo Desejado',
                              value: _resume.objective.desiredJob,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: ResumeFieldViewer(
                              label: 'Disponibilidade',
                              value: _resume.objective.availability,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: ResumeFieldViewer(
                              label: 'Primeiro Emprego?',
                              value: _resume.objective.firstJob ? 'Sim' : 'Não',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Áreas de Interesse',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _resume.objective.areasOfInterest
                            .map(
                              (area) => Chip(
                                label: Text(area),
                                backgroundColor: AppTheme.primaryColor
                                    .withAlpha(20),
                                side: BorderSide.none,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 300.ms).slideX(begin: -0.05),

                // Seção 4: Experiência Profissional
                ResumeSectionCard(
                  title: 'Experiência Profissional',
                  icon: Icons.work_outline,
                  onEdit: () => _showEditModal('Experiências'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._resume.experiences.map(
                        (exp) => Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.business,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exp.role,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${exp.company} • ${exp.startDate} - ${exp.isCurrent ? 'Atual' : exp.endDate}',
                                      style: const TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      exp.description,
                                      style: const TextStyle(
                                        color: AppTheme.textSecondary,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _showEditModal('Nova Experiência'),
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar Experiência'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          side: BorderSide(
                            color: AppTheme.primaryColor.withAlpha(50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 400.ms).slideX(begin: -0.05),

                // Seção 5: Formação Acadêmica
                ResumeSectionCard(
                  title: 'Formação Acadêmica',
                  icon: Icons.school_outlined,
                  onEdit: () => _showEditModal('Formação'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._resume.education.map(
                        (edu) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.menu_book,
                                color: AppTheme.textSecondary,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      edu.degree,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      edu.institution,
                                      style: const TextStyle(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 500.ms).slideX(begin: -0.05),

                // Seção 6: Qualificações e Habilidades
                ResumeSectionCard(
                  title: 'Cursos, Qualificações e Habilidades',
                  icon: Icons.stars_outlined,
                  onEdit: () => _showEditModal('Qualificações'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ResumeFieldViewer(
                              label: 'Carteira de Habilitação (CNH)',
                              value: 'Categoria ${_resume.qualifications.cnh}',
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Idiomas',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _resume.qualifications.languages
                                      .map((l) => '${l.name} (${l.level})')
                                      .join(', '),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Cursos Extras',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ..._resume.qualifications.extraCourses.map(
                        (c) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(c),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Habilidades',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _resume.qualifications.skills
                            .map(
                              (skill) => Chip(
                                label: Text(skill),
                                backgroundColor: AppTheme.surfaceColor,
                                side: const BorderSide(color: Colors.black12),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 600.ms).slideX(begin: -0.05),

                // Seção 7: Portfólio e Links
                ResumeSectionCard(
                  title: 'Portfólio e Links',
                  icon: Icons.link,
                  isCompleted: false, // Simulando que falta preencher
                  onEdit: () => _showEditModal('Links'),
                  child: Wrap(
                    spacing: 24,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: 300,
                        child: ResumeFieldViewer(
                          label: 'LinkedIn',
                          value: _resume.portfolio.linkedIn,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: ResumeFieldViewer(
                          label: 'Link Externo (Site/Portfólio)',
                          value: _resume.portfolio.externalLink,
                        ),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 700.ms).slideX(begin: -0.05),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
