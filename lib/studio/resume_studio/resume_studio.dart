import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:conecta/theme/app_theme.dart';
import 'package:conecta/models/worker/resume_model.dart';
import 'dart:typed_data';

import 'templates/resume_templates.dart';
import 'components/template_selector_modal.dart';

class ResumeStudio extends StatefulWidget {
  final ResumeModel resumeData;

  const ResumeStudio({super.key, required this.resumeData});

  @override
  State<ResumeStudio> createState() => _ResumeStudioState();
}

class _ResumeStudioState extends State<ResumeStudio> with SingleTickerProviderStateMixin {
  ResumeTemplate _currentTemplate = ResumeTemplate.modern;
  Key _pdfPreviewKey = UniqueKey();
  
  // Fab Animation
  late AnimationController _fabController;
  bool _isFabOpen = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isFabOpen = !_isFabOpen;
      if (_isFabOpen) {
        _fabController.forward();
      } else {
        _fabController.reverse();
      }
    });
  }

  void _showTemplateSelector() {
    if (_isFabOpen) _toggleFab();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TemplateSelectorModal(
        currentTemplate: _currentTemplate,
        onTemplateSelected: (template) {
          setState(() {
            _currentTemplate = template;
            _pdfPreviewKey = UniqueKey(); // Força a atualização
          });
        },
      ),
    );
  }

  Future<void> _shareOrDownloadPdf() async {
    if (_isFabOpen) _toggleFab();
    try {
      final doc = await ResumeTemplates.generate(widget.resumeData, _currentTemplate);
      final bytes = await doc.save();
      final filename = 'curriculo_${widget.resumeData.personalInfo.fullName.replaceAll(' ', '_').toLowerCase()}.pdf';
      await Printing.sharePdf(bytes: bytes, filename: filename);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao processar PDF: $e')),
        );
      }
    }
  }
  
  Future<void> _printPdf() async {
    if (_isFabOpen) _toggleFab();
    try {
      final doc = await ResumeTemplates.generate(widget.resumeData, _currentTemplate);
      final bytes = await doc.save();
      final filename = 'curriculo_${widget.resumeData.personalInfo.fullName.replaceAll(' ', '_').toLowerCase()}.pdf';
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => bytes,
        name: filename,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao imprimir PDF: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryDark.withAlpha(200),
                  AppTheme.primaryColor.withAlpha(150),
                  AppTheme.surfaceColor,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          
          // PDF Preview Area - Edge to Edge
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Custom App Bar (Glassmorphism) without top right icon
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withAlpha(50),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Resume Studio',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().slideY(begin: -1, duration: 400.ms, curve: Curves.easeOut),
                
                // PDF Viewer - Ocupando todo o espaço disponível
                Expanded(
                  child: PdfPreview(
                    key: _pdfPreviewKey,
                    build: (format) => ResumeTemplates.generate(widget.resumeData, _currentTemplate)
                        .then((doc) => doc.save()),
                    useActions: false, // Remove a action bar nativa
                    allowPrinting: false,
                    allowSharing: false,
                    canChangeOrientation: false,
                    canChangePageFormat: false,
                    canDebug: false,
                    maxPageWidth: 800, // Limita para parecer folha A4 real sem achatar demais
                    initialPageFormat: PdfPageFormat.a4,
                    pdfFileName: 'curriculo_${widget.resumeData.personalInfo.fullName.replaceAll(' ', '_').toLowerCase()}.pdf',
                    loadingWidget: const Center(
                      child: CircularProgressIndicator(color: AppTheme.primaryColor),
                    ),
                    scrollViewDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    pdfPreviewPageDecoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(50),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms),
                ),
              ],
            ),
          ),
          
          // Custom Expandable FAB
          Positioned(
            bottom: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Item 1: Modelos
                ScaleTransition(
                  scale: CurvedAnimation(parent: _fabController, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: FloatingActionButton.small(
                      heroTag: 'fab_modelos',
                      onPressed: _showTemplateSelector,
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryColor,
                      tooltip: 'Mudar Modelo',
                      child: const Icon(Icons.style),
                    ),
                  ),
                ),
                // Item 2: Compartilhar / Baixar
                ScaleTransition(
                  scale: CurvedAnimation(parent: _fabController, curve: const Interval(0.2, 0.7, curve: Curves.easeOut)),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: FloatingActionButton.small(
                      heroTag: 'fab_share',
                      onPressed: _shareOrDownloadPdf,
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryColor,
                      tooltip: 'Baixar / Compartilhar',
                      child: const Icon(Icons.share),
                    ),
                  ),
                ),
                // Item 3: Imprimir
                ScaleTransition(
                  scale: CurvedAnimation(parent: _fabController, curve: const Interval(0.4, 0.9, curve: Curves.easeOut)),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: FloatingActionButton.small(
                      heroTag: 'fab_print',
                      onPressed: _printPdf,
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryColor,
                      tooltip: 'Imprimir',
                      child: const Icon(Icons.print),
                    ),
                  ),
                ),
                // Main Toggle FAB
                FloatingActionButton(
                  heroTag: 'fab_main',
                  onPressed: _toggleFab,
                  backgroundColor: AppTheme.primaryColor,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _fabController,
                    color: Colors.white,
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
