import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:conecta/models/worker/resume_model.dart';

class TemplateMinimalista {
  static pw.Page build(ResumeModel resume) {
    // Focamos unicamente em fontes Sans-Serif para o visual moderno e limpo
    final sansRegular = pw.Font.helvetica();
    final sansBold = pw.Font.helveticaBold();
    
    // Paleta de tons de cinza extremamente calculada
    final black = PdfColor.fromHex('#111111');
    final darkGrey = PdfColor.fromHex('#444444');
    final mediumGrey = PdfColor.fromHex('#777777');
    final lightGrey = PdfColor.fromHex('#AAAAAA');

    return pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 50, vertical: 60),
      build: (pw.Context context) {
        return [
          // ================= HEADER =================
          pw.Text(
            resume.personalInfo.fullName.toUpperCase(),
            style: pw.TextStyle(
              font: sansBold,
              fontSize: 34,
              color: black,
              letterSpacing: 2,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            resume.objective.desiredJob.toUpperCase(),
            style: pw.TextStyle(
              font: sansRegular,
              fontSize: 12,
              color: mediumGrey,
              letterSpacing: 3,
            ),
          ),
          pw.SizedBox(height: 24),
          pw.Text(
            '${resume.contactInfo.phone}   /   ${resume.contactInfo.email}   /   ${resume.contactInfo.address}',
            style: pw.TextStyle(font: sansRegular, fontSize: 10, color: darkGrey),
          ),
          if (resume.portfolio.linkedIn.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              resume.portfolio.linkedIn,
              style: pw.TextStyle(font: sansRegular, fontSize: 10, color: darkGrey),
            ),
          ],
          
          pw.SizedBox(height: 48),

          // ================= OBJETIVO =================
          _buildRowSection(
            'PERFIL',
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Objetivo: ${resume.objective.desiredJob}',
                  style: pw.TextStyle(font: sansRegular, fontSize: 11, color: darkGrey, lineSpacing: 4),
                ),
                if (resume.objective.areasOfInterest.isNotEmpty) ...[
                  pw.SizedBox(height: 6),
                  pw.Text(
                    'Áreas: ${resume.objective.areasOfInterest.join(", ")}',
                    style: pw.TextStyle(font: sansRegular, fontSize: 11, color: mediumGrey, lineSpacing: 4),
                  ),
                ],
              ],
            ),
            sansBold,
            lightGrey,
          ),
          pw.SizedBox(height: 36),

          // ================= EXPERIÊNCIA =================
          if (resume.experiences.isNotEmpty) ...[
            _buildRowSection(
              'EXPERIÊNCIA',
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: resume.experiences.map((exp) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 28),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            child: pw.Text(
                              exp.role,
                              style: pw.TextStyle(font: sansBold, fontSize: 12, color: black),
                            ),
                          ),
                          pw.Text(
                            '${exp.startDate} - ${exp.isCurrent ? 'Presente' : exp.endDate}',
                            style: pw.TextStyle(font: sansRegular, fontSize: 10, color: mediumGrey),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        exp.company,
                        style: pw.TextStyle(font: sansRegular, fontSize: 11, color: darkGrey),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        exp.description,
                        style: pw.TextStyle(font: sansRegular, fontSize: 10, color: mediumGrey, lineSpacing: 4),
                      ),
                    ],
                  ),
                )).toList(),
              ),
              sansBold,
              lightGrey,
            ),
            pw.SizedBox(height: 8),
          ],

          // ================= FORMAÇÃO =================
          if (resume.education.isNotEmpty) ...[
            _buildRowSection(
              'FORMAÇÃO',
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: resume.education.map((edu) => pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 24),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        edu.degree,
                        style: pw.TextStyle(font: sansBold, fontSize: 12, color: black),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        edu.institution,
                        style: pw.TextStyle(font: sansRegular, fontSize: 11, color: darkGrey),
                      ),
                    ],
                  ),
                )).toList(),
              ),
              sansBold,
              lightGrey,
            ),
            pw.SizedBox(height: 12),
          ],

          // ================= HABILIDADES =================
          _buildRowSection(
            'HABILIDADES',
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: resume.qualifications.skills.map((s) => pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColor.fromHex('#EEEEEE'), width: 1),
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                    ),
                    child: pw.Text(
                      s,
                      style: pw.TextStyle(font: sansRegular, fontSize: 10, color: darkGrey),
                    ),
                  )).toList(),
                ),
                pw.SizedBox(height: 28),
                pw.Text('Idiomas', style: pw.TextStyle(font: sansRegular, fontSize: 10, color: lightGrey, letterSpacing: 1)),
                pw.SizedBox(height: 10),
                ...resume.qualifications.languages.map((l) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 6),
                  child: pw.Text('${l.name} (${l.level})', style: pw.TextStyle(font: sansRegular, fontSize: 11, color: darkGrey)),
                )),
                
                if (resume.qualifications.extraCourses.isNotEmpty) ...[
                  pw.SizedBox(height: 24),
                  pw.Text('Cursos Extras', style: pw.TextStyle(font: sansRegular, fontSize: 10, color: lightGrey, letterSpacing: 1)),
                  pw.SizedBox(height: 10),
                  ...resume.qualifications.extraCourses.map((c) => pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 6),
                    child: pw.Text(c, style: pw.TextStyle(font: sansRegular, fontSize: 11, color: darkGrey)),
                  )),
                ]
              ],
            ),
            sansBold,
            lightGrey,
          ),
        ];
      },
    );
  }

  static pw.Widget _buildRowSection(String title, pw.Widget content, pw.Font titleFont, PdfColor titleColor) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 140,
          padding: const pw.EdgeInsets.only(right: 20, top: 2),
          child: pw.Text(
            title,
            style: pw.TextStyle(
              font: titleFont,
              fontSize: 10,
              color: titleColor,
              letterSpacing: 2.5,
            ),
          ),
        ),
        pw.Expanded(child: content),
      ],
    );
  }
}
