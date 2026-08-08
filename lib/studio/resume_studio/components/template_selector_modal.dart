import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:conecta/theme/app_theme.dart';
import '../templates/resume_templates.dart';

class TemplateSelectorModal extends StatefulWidget {
  final ResumeTemplate currentTemplate;
  final Function(ResumeTemplate) onTemplateSelected;

  const TemplateSelectorModal({
    super.key,
    required this.currentTemplate,
    required this.onTemplateSelected,
  });

  @override
  State<TemplateSelectorModal> createState() => _TemplateSelectorModalState();
}

class _TemplateSelectorModalState extends State<TemplateSelectorModal> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentIndex = 0;
  String _searchQuery = '';

  final List<Map<String, dynamic>> _allTemplates = [
    {
      'id': ResumeTemplate.modern,
      'name': 'Moderno',
      'description': 'Design elegante e limpo com barra lateral em destaque.',
      'color': const Color(0xFF2B2D42),
      'icon': Icons.view_sidebar_outlined,
    },
    {
      'id': ResumeTemplate.classic,
      'name': 'Clássico',
      'description': 'Formato tradicional focado na legibilidade e clareza.',
      'color': const Color(0xFF8D99AE),
      'icon': Icons.article_outlined,
    },
    {
      'id': ResumeTemplate.minimalist,
      'name': 'Minimalista',
      'description': 'Apenas o essencial, com amplo espaço em branco e tipografia forte.',
      'color': const Color(0xFF4A4A4A),
      'icon': Icons.space_dashboard_outlined,
    },
    {
      'id': ResumeTemplate.tech,
      'name': 'Tech',
      'description': 'Layout moderno e inovador com foto, cores marcantes e formato de cards.',
      'color': const Color(0xFF5E8E9F),
      'icon': Icons.computer_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = _allTemplates.indexWhere((t) => t['id'] == widget.currentTemplate);
    if (_currentIndex == -1) _currentIndex = 0;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(_currentIndex);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildMiniPreview(ResumeTemplate type) {
    if (type == ResumeTemplate.modern) {
      return Row(
        children: [
          Container(width: 25, color: const Color(0xFF2B2D42)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 4, width: 25, color: Colors.grey[400]),
                  const SizedBox(height: 4),
                  Container(height: 2, width: 15, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Container(height: 3, width: 20, color: Colors.grey[400]),
                  const SizedBox(height: 3),
                  Container(height: 2, width: 35, color: Colors.grey[200]),
                  const SizedBox(height: 2),
                  Container(height: 2, width: 30, color: Colors.grey[200]),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (type == ResumeTemplate.classic) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 5, width: 40, color: Colors.grey[400]),
            const SizedBox(height: 3),
            Container(height: 2, width: 20, color: Colors.grey[300]),
            const SizedBox(height: 8),
            Container(height: 1, width: double.infinity, color: Colors.grey[300]),
            const SizedBox(height: 4),
            Container(height: 3, width: 30, color: Colors.grey[400]),
            const SizedBox(height: 4),
            Container(height: 2, width: double.infinity, color: Colors.grey[200]),
            const SizedBox(height: 2),
            Container(height: 2, width: 35, color: Colors.grey[200]),
          ],
        ),
      );
    } else if (type == ResumeTemplate.minimalist) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 3, width: 15, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Container(height: 3, width: 15, color: Colors.grey[300]),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 5, width: 30, color: Colors.grey[400]),
                  const SizedBox(height: 3),
                  Container(height: 2, width: 20, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Container(height: 2, width: double.infinity, color: Colors.grey[200]),
                  const SizedBox(height: 2),
                  Container(height: 2, width: 25, color: Colors.grey[200]),
                  const SizedBox(height: 6),
                  Container(height: 2, width: double.infinity, color: Colors.grey[200]),
                  const SizedBox(height: 2),
                  Container(height: 2, width: 25, color: Colors.grey[200]),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFF5E8E9F),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Container(width: 14, height: 14, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 4, width: 30, color: Colors.white),
                    const SizedBox(height: 2),
                    Container(height: 2, width: 20, color: Colors.white70),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
              ),
              padding: const EdgeInsets.all(6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(height: 20, width: double.infinity, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4))),
                        const SizedBox(height: 4),
                        Container(height: 20, width: double.infinity, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    flex: 5,
                    child: Container(height: 44, width: double.infinity, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4))),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  List<Map<String, dynamic>> get _filteredTemplates {
    if (_searchQuery.isEmpty) return _allTemplates;
    return _allTemplates
        .where((t) => t['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(80),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Escolha seu Modelo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ).animate().fadeIn().slideY(begin: 0.2),
          const SizedBox(height: 16),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Pesquisar modelos...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                filled: true,
                fillColor: AppTheme.primaryColor.withAlpha(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
          
          const SizedBox(height: 32),
          
          // Carousel
          Expanded(
            child: _filteredTemplates.isEmpty
                ? const Center(child: Text('Nenhum modelo encontrado.'))
                : Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: PageView.builder(
                        controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentIndex = index),
                    itemCount: _filteredTemplates.length,
                    itemBuilder: (context, index) {
                      final template = _filteredTemplates[index];
                      final isSelected = widget.currentTemplate == template['id'];
                      
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                          }
                          return Center(
                            child: SizedBox(
                              height: Curves.easeOut.transform(value) * 400,
                              width: Curves.easeOut.transform(value) * 300,
                              child: child,
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            widget.onTemplateSelected(template['id']);
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: template['color'].withAlpha(isSelected ? 80 : 30),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              border: Border.all(
                                color: isSelected ? AppTheme.primaryColor : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: template['color'].withAlpha(isSelected ? 255 : 180),
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 90,
                                        height: 127,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withAlpha(30),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: _buildMiniPreview(template['id']),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              template['name'],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
                                              ),
                                            ),
                                            if (isSelected)
                                              const Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 20),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Expanded(
                                          child: Text(
                                            template['description'],
                                            style: const TextStyle(
                                              color: AppTheme.textSecondary,
                                              height: 1.3,
                                              fontSize: 13,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.9, 0.9)),
            ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
