import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:conecta/models/worker/resume_model.dart';

class TemplateModerno {
  static pw.Page build(ResumeModel resume) {
    return pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        buildBackground: (pw.Context context) {
          return pw.Row(
            children: [
              pw.Container(width: 200, color: PdfColor.fromHex('#2B2D42')),
              pw.Expanded(child: pw.Container(color: PdfColors.white)),
            ],
          );
        },
      ),
      build: (pw.Context context) {
        return [
          pw.Partitions(
            children: [
              // Sidebar
              pw.Partition(
                width: 200,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(24),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        resume.personalInfo.fullName,
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 34,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 16),
                      pw.Text(
                        resume.objective.desiredJob,
                        style: pw.TextStyle(
                          color: PdfColor.fromHex('#8D99AE'),
                          fontSize: 18,
                        ),
                      ),
                      pw.SizedBox(height: 32),
                      _modernSectionTitle('CONTATO', PdfColors.white),
                      _modernContactItem('Telefone', resume.contactInfo.phone),
                      _modernContactItem('Email', resume.contactInfo.email),
                      _modernContactItem(
                        'Endereço',
                        '${resume.contactInfo.address}\n${resume.contactInfo.neighborhood}',
                      ),
                      if (resume.portfolio.linkedIn.isNotEmpty)
                        _modernContactItem(
                          'LinkedIn',
                          resume.portfolio.linkedIn,
                        ),
                      pw.SizedBox(height: 32),
                      _modernSectionTitle('HABILIDADES', PdfColors.white),
                      ...resume.qualifications.skills.map(
                        (s) => pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 8),
                          child: pw.Text(
                            '- $s',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 32),
                      _modernSectionTitle('IDIOMAS', PdfColors.white),
                      ...resume.qualifications.languages.map(
                        (l) => pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 8),
                          child: pw.Text(
                            '${l.name} - ${l.level}',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), // <-- Fechamento da Partition Sidebar
              // Main Content
              pw.Partition(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 48, vertical: 40),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                        _modernSectionTitle(
                          'PERFIL PROFISSIONAL',
                          PdfColor.fromHex('#2B2D42'),
                        ),
                        pw.Text(
                          'Objetivo: ${resume.objective.desiredJob}\nÁreas de Interesse: ${resume.objective.areasOfInterest.join(", ")}',
                          style: pw.TextStyle(
                            fontSize: 13,
                            color: PdfColors.black,
                            lineSpacing: 6,
                          ),
                        ),
                        pw.SizedBox(height: 32),
                        _modernSectionTitle(
                          'EXPERIÊNCIA PROFISSIONAL',
                          PdfColor.fromHex('#2B2D42'),
                        ),
                        ...resume.experiences.map(
                          (exp) => pw.Container(
                            margin: const pw.EdgeInsets.only(bottom: 24),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  exp.role,
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                pw.SizedBox(height: 6),
                                pw.Text(
                                  '${exp.company} | ${exp.startDate} - ${exp.isCurrent ? 'Atual' : exp.endDate}',
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex('#8D99AE'),
                                    fontSize: 13,
                                  ),
                                ),
                                pw.SizedBox(height: 12),
                                pw.Text(
                                  exp.description,
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    lineSpacing: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 32),
                        _modernSectionTitle(
                          'FORMAÇÃO ACADÊMICA',
                          PdfColor.fromHex('#2B2D42'),
                        ),
                        ...resume.education.map(
                          (edu) => pw.Container(
                            margin: const pw.EdgeInsets.only(bottom: 24),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  edu.degree,
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                pw.SizedBox(height: 6),
                                pw.Text(
                                  edu.institution,
                                  style: pw.TextStyle(
                                    color: PdfColor.fromHex('#8D99AE'),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 32),
                        if (resume.qualifications.extraCourses.isNotEmpty) ...[
                          _modernSectionTitle(
                            'CURSOS EXTRAS',
                            PdfColor.fromHex('#2B2D42'),
                          ),
                          ...resume.qualifications.extraCourses.map(
                            (c) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 6),
                              child: pw.Text(
                                '- $c',
                                style: pw.TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ];
      },
    );
  }

  static pw.Widget _modernSectionTitle(String title, PdfColor color) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Container(height: 1.5, width: 40, color: color),
        ],
      ),
    );
  }

  static pw.Widget _modernContactItem(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              color: PdfColor.fromHex('#8D99AE'),
              fontSize: 10,
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            value,
            style: pw.TextStyle(color: PdfColors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
