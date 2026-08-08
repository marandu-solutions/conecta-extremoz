import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:conecta/models/worker/resume_model.dart';

class TemplateClassico {
  static pw.Page build(ResumeModel resume) {
    // Definindo as fontes clássicas e elegantes
    final serifFont = pw.Font.times();
    final serifBold = pw.Font.timesBold();
    final serifItalic = pw.Font.timesItalic();
    
    final sansFont = pw.Font.helvetica();
    final sansBold = pw.Font.helveticaBold();
    
    // Paleta de cores sofisticada (Noir & Navy)
    final primaryColor = PdfColor.fromHex('#1A1A1A'); // Quase preto, mais requintado que o preto puro
    final secondaryColor = PdfColor.fromHex('#555555'); // Cinza escuro para detalhes
    final accentColor = PdfColor.fromHex('#2C3E50'); // Azul marinho muito escuro e clássico
    final lightGrey = PdfColor.fromHex('#D5D8DC'); // Cinza claro para as linhas e divisórias

    return pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 56, vertical: 64),
      build: (pw.Context context) {
        return [
          // ================= HEADER =================
          pw.Center(
            child: pw.Text(
              resume.personalInfo.fullName.toUpperCase(),
              style: pw.TextStyle(
                font: serifBold,
                fontSize: 32,
                color: primaryColor,
                letterSpacing: 2,
              ),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Center(
            child: pw.Text(
              resume.objective.desiredJob.toUpperCase(),
              style: pw.TextStyle(
                font: sansBold,
                fontSize: 12,
                color: accentColor,
                letterSpacing: 1.5,
              ),
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Center(
            child: pw.Text(
              '${resume.contactInfo.phone}   |   ${resume.contactInfo.email}\n${resume.contactInfo.address}, ${resume.contactInfo.neighborhood}',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: sansFont,
                fontSize: 10,
                color: secondaryColor,
                lineSpacing: 4,
              ),
            ),
          ),
          if (resume.portfolio.linkedIn.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Center(
              child: pw.Text(
                resume.portfolio.linkedIn,
                style: pw.TextStyle(font: sansFont, fontSize: 10, color: secondaryColor),
              ),
            ),
          ],
          
          pw.SizedBox(height: 24),
          pw.Divider(color: lightGrey, thickness: 1),
          pw.SizedBox(height: 24),

          // ================= PERFIL PROFISSIONAL =================
          _buildSectionTitle('PERFIL PROFISSIONAL', serifBold, accentColor, lightGrey),
          pw.Text(
            'Objetivo: ${resume.objective.desiredJob}',
            style: pw.TextStyle(font: sansFont, fontSize: 11, color: primaryColor, lineSpacing: 4),
          ),
          if (resume.objective.areasOfInterest.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              'Áreas de Interesse: ${resume.objective.areasOfInterest.join(", ")}',
              style: pw.TextStyle(font: sansFont, fontSize: 11, color: primaryColor, lineSpacing: 4),
            ),
          ],
          pw.SizedBox(height: 28),

          // ================= EXPERIÊNCIA PROFISSIONAL =================
          if (resume.experiences.isNotEmpty) ...[
            _buildSectionTitle('EXPERIÊNCIA PROFISSIONAL', serifBold, accentColor, lightGrey),
            ...resume.experiences.map((exp) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.RichText(
                              text: pw.TextSpan(
                                children: [
                                  pw.TextSpan(
                                    text: exp.role,
                                    style: pw.TextStyle(font: sansBold, fontSize: 13, color: primaryColor),
                                  ),
                                  pw.TextSpan(
                                    text: '   |   ',
                                    style: pw.TextStyle(font: sansFont, fontSize: 12, color: lightGrey),
                                  ),
                                  pw.TextSpan(
                                    text: exp.company,
                                    style: pw.TextStyle(font: serifItalic, fontSize: 13, color: accentColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.Text(
                            '${exp.startDate} - ${exp.isCurrent ? 'O momento' : exp.endDate}',
                            style: pw.TextStyle(font: sansFont, fontSize: 11, color: secondaryColor),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        exp.description,
                        style: pw.TextStyle(font: sansFont, fontSize: 11, color: primaryColor, lineSpacing: 3),
                      ),
                    ],
                  ),
                )),
            pw.SizedBox(height: 8),
          ],

          // ================= FORMAÇÃO ACADÊMICA =================
          if (resume.education.isNotEmpty) ...[
            _buildSectionTitle('FORMAÇÃO ACADÊMICA', serifBold, accentColor, lightGrey),
            ...resume.education.map((edu) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 16),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(edu.degree, style: pw.TextStyle(font: sansBold, fontSize: 12, color: primaryColor)),
                            pw.SizedBox(height: 4),
                            pw.Text(edu.institution, style: pw.TextStyle(font: serifItalic, fontSize: 12, color: accentColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            pw.SizedBox(height: 12),
          ],
          
          // ================= COMPETÊNCIAS & IDIOMAS =================
          _buildSectionTitle('COMPETÊNCIAS & IDIOMAS', serifBold, accentColor, lightGrey),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Habilidades Técnicas', style: pw.TextStyle(font: sansBold, fontSize: 11, color: accentColor)),
                    pw.SizedBox(height: 10),
                    ...resume.qualifications.skills.map((s) => pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 6),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 3,
                            height: 3,
                            margin: const pw.EdgeInsets.only(top: 4, right: 8),
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              color: accentColor,
                            ),
                          ),
                          pw.Expanded(child: pw.Text(s, style: pw.TextStyle(font: sansFont, fontSize: 11, color: primaryColor, lineSpacing: 2))),
                        ]
                      )
                    )),
                  ],
                ),
              ),
              pw.SizedBox(width: 32),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Idiomas', style: pw.TextStyle(font: sansBold, fontSize: 11, color: accentColor)),
                    pw.SizedBox(height: 10),
                    ...resume.qualifications.languages.map((l) => pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 6),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 3,
                            height: 3,
                            margin: const pw.EdgeInsets.only(top: 4, right: 8),
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              color: accentColor,
                            ),
                          ),
                          pw.Expanded(child: pw.Text('${l.name} (${l.level})', style: pw.TextStyle(font: sansFont, fontSize: 11, color: primaryColor))),
                        ]
                      )
                    )),
                    if (resume.qualifications.extraCourses.isNotEmpty) ...[
                      pw.SizedBox(height: 16),
                      pw.Text('Cursos Extras', style: pw.TextStyle(font: sansBold, fontSize: 11, color: accentColor)),
                      pw.SizedBox(height: 10),
                      ...resume.qualifications.extraCourses.map((c) => pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 6),
                        child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                              width: 3,
                              height: 3,
                              margin: const pw.EdgeInsets.only(top: 4, right: 8),
                              decoration: pw.BoxDecoration(
                                shape: pw.BoxShape.circle,
                                color: accentColor,
                              ),
                            ),
                            pw.Expanded(child: pw.Text(c, style: pw.TextStyle(font: sansFont, fontSize: 11, color: primaryColor, lineSpacing: 2))),
                          ]
                        )
                      )),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ];
      },
    );
  }

  static pw.Widget _buildSectionTitle(String title, pw.Font font, PdfColor textColor, PdfColor dividerColor) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              font: font,
              fontSize: 14,
              color: textColor,
              letterSpacing: 1.2,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Container(
            height: 1.5,
            width: double.infinity,
            color: dividerColor,
          ),
        ],
      ),
    );
  }
}
