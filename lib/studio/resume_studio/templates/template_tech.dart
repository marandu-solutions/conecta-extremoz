import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:conecta/models/worker/resume_model.dart';

const svgUser = '<svg viewBox="0 0 24 24"><path fill="#COLOR_PLACEHOLDER" d="M12,4A4,4 0 0,1 16,8A4,4 0 0,1 12,12A4,4 0 0,1 8,8A4,4 0 0,1 12,4M12,14C16.42,14 20,15.79 20,18V20H4V18C4,15.79 7.58,14 12,14Z" /></svg>';
const svgHat = '<svg viewBox="0 0 24 24"><path fill="#COLOR_PLACEHOLDER" d="M12,3L1,9L4,10.64V17.18L12,21L20,17.18V10.64L22.09,9.54L23,9M12,5.2L18.4,8.6L12,12L5.6,8.6L12,5.2M12,18.8L6,15.9V11.7L12,15L18,11.7V15.9L12,18.8Z" /></svg>';
const svgCode = '<svg viewBox="0 0 24 24"><path fill="#COLOR_PLACEHOLDER" d="M14.6,16.6L19.2,12L14.6,7.4L16,6L22,12L16,18L14.6,16.6M9.4,16.6L4.8,12L9.4,7.4L8,6L2,12L8,18L9.4,16.6Z" /></svg>';
const svgBag = '<svg viewBox="0 0 24 24"><path fill="#COLOR_PLACEHOLDER" d="M10,2H14A2,2 0 0,1 16,4V6H20A2,2 0 0,1 22,8V19A2,2 0 0,1 20,21H4C2.89,21 2,20.1 2,19V8C2,6.89 2.89,6 4,6H8V4C8,2.89 8.89,2 10,2M14,6V4H10V6H14Z" /></svg>';
const svgFolder = '<svg viewBox="0 0 24 24"><path fill="#COLOR_PLACEHOLDER" d="M20,6H12L10,4H4C2.89,4 2,4.89 2,6V18C2,19.1 2.9,20 4,20H20C21.1,20 22,19.1 22,18V8C22,6.9 21.1,6 20,6M20,18H4V8H20V18Z" /></svg>';

class TemplateTech {
  static pw.Page build(ResumeModel resume, Uint8List? profileImage) {
    // Paleta de cores inspirada no mockup
    final primaryBlue = PdfColor.fromHex('#5E8E9F');
    final backgroundGrey = PdfColor.fromHex('#F4F5F7');
    final textDark = PdfColor.fromHex('#2E3540');
    final textGrey = PdfColor.fromHex('#6A7B8E');
    final white = PdfColor.fromHex('#FFFFFF');
    final cardBg = PdfColor.fromHex('#E6ECF1');

    return pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        buildBackground: (pw.Context context) {
          if (context.pageNumber == 1) {
            return pw.Stack(
              children: [
                // Fundo da página
                pw.Container(color: backgroundGrey),
                // Header azul
                pw.Container(
                  height: 260,
                  color: primaryBlue,
                ),
                // Círculos de fundo do header (decoração abstrata)
                pw.Positioned(
                  right: -60,
                  top: -60,
                  child: pw.Container(
                    width: 320,
                    height: 320,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      color: PdfColor.fromHex('#78A9BB'),
                    ),
                  ),
                ),
                pw.Positioned(
                  left: -120,
                  top: 80,
                  child: pw.Container(
                    width: 280,
                    height: 280,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      color: PdfColor.fromHex('#689CAE'),
                    ),
                  ),
                ),
                // Fundo branco arredondado cobrindo a base do header azul
                pw.Positioned(
                  top: 210,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      color: backgroundGrey,
                      borderRadius: const pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(40),
                        topRight: pw.Radius.circular(40),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return pw.Container(color: backgroundGrey);
          }
        },
      ),
      build: (pw.Context context) {
        return [
          // Espaço do topo do header até o conteúdo (50px)
          pw.SizedBox(height: 50),
          
          // Row do perfil (fica por cima do header azul)
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 50),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    if (profileImage != null)
                      pw.Container(
                        width: 110,
                        height: 110,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          color: white,
                          image: pw.DecorationImage(
                            image: pw.MemoryImage(profileImage),
                            fit: pw.BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      pw.Container(
                        width: 110,
                        height: 110,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          color: PdfColors.grey300,
                        ),
                      ),
                    pw.SizedBox(width: 24),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Olá, eu sou', style: pw.TextStyle(color: white, fontSize: 16)),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          resume.personalInfo.fullName,
                          style: pw.TextStyle(color: white, fontSize: 36, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          resume.objective.desiredJob.toLowerCase(),
                          style: pw.TextStyle(color: white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Text(
                  resume.contactInfo.phone,
                  style: pw.TextStyle(color: white, fontSize: 11),
                ),
              ],
            ),
          ),
          
          // Espaço até começar o container branco (210 - 50 - 110 = 50)
          pw.SizedBox(height: 50),

          // Começo do conteúdo principal
          pw.SizedBox(height: 36), // Padding interno top do fundo branco
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 40),
            child: pw.Text('Curriculum vitae', style: pw.TextStyle(color: textGrey, fontSize: 14, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 20),
          
          // Multi-página compatível colunas usando pw.Partitions
          pw.Partitions(
            children: [
              pw.Partition(
                width: 250,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 40, right: 12),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Sobre mim
                      _buildCard(
                        cardBg, textDark, textGrey, 'Sobre mim',
                        resume.objective.desiredJob, svgUser,
                      ),
                      pw.SizedBox(height: 20),
                      // Formação
                      _buildCardWithList(
                        cardBg, textDark, textGrey, 'Formação Acadêmica',
                        resume.education.map((e) => [
                          pw.Text(e.degree, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: textDark)),
                          pw.SizedBox(height: 2),
                          pw.Text(e.institution, style: pw.TextStyle(fontSize: 10, color: textGrey)),
                        ]).toList(),
                        svgHat,
                      ),
                      pw.SizedBox(height: 20),
                      // Habilidades
                      _buildCard(
                        cardBg, textDark, textGrey, 'Habilidades',
                        resume.qualifications.skills.join('; '), svgCode,
                      ),
                    ],
                  ),
                ),
              ),
              pw.Partition(
                flex: 1,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 12, right: 40),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildCardWithList(
                        cardBg, textDark, textGrey, 'Experiência Profissional',
                        resume.experiences.map((exp) => [
                          pw.Text(exp.role, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: textDark)),
                          pw.SizedBox(height: 2),
                          pw.Text('${exp.company}, ${exp.startDate} - ${exp.isCurrent ? 'Presente' : exp.endDate}', style: pw.TextStyle(fontSize: 10, color: textGrey)),
                          pw.SizedBox(height: 6),
                          pw.Text(exp.description, style: pw.TextStyle(fontSize: 10, color: textGrey, lineSpacing: 2)),
                        ]).toList(),
                        svgBag,
                      ),
                      pw.SizedBox(height: 20),
                      _buildCardWithList(
                        cardBg, textDark, textGrey, 'Portfólio',
                        [
                          [
                            pw.Text('Clarinha', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: textDark)),
                            pw.SizedBox(height: 2),
                            pw.Text('I.A via whatsapp para tomada de decisão no campo', style: pw.TextStyle(fontSize: 10, color: textGrey, lineSpacing: 2)),
                          ],
                          [
                            pw.Text('Conecta Extremoz', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: textDark)),
                            pw.SizedBox(height: 2),
                            pw.Text('Plataforma que conecta empresários a jovens capacitados', style: pw.TextStyle(fontSize: 10, color: textGrey, lineSpacing: 2)),
                          ],
                          [
                            pw.Text('VOTE', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: textDark)),
                            pw.SizedBox(height: 2),
                            pw.Text('Visão e Organização Técnica Eleitoral', style: pw.TextStyle(fontSize: 10, color: textGrey, lineSpacing: 2)),
                          ],
                          [
                            pw.Text('Smart Aprove', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: textDark)),
                            pw.SizedBox(height: 2),
                            pw.Text('Plataforma de análise documental com I.A', style: pw.TextStyle(fontSize: 10, color: textGrey, lineSpacing: 2)),
                          ],
                        ],
                        svgFolder,
                      ),
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

  static pw.Widget _buildCard(PdfColor bg, PdfColor titleColor, PdfColor textColor, String title, String content, String svgIcon) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: bg,
        borderRadius: pw.BorderRadius.circular(24),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 24, height: 24,
            margin: const pw.EdgeInsets.only(bottom: 12),
            child: pw.SvgImage(svg: svgIcon.replaceAll('#COLOR_PLACEHOLDER', titleColor.toHex())),
          ),
          pw.Text(title, style: pw.TextStyle(color: titleColor, fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 12),
          pw.Text(content, style: pw.TextStyle(color: textColor, fontSize: 11, lineSpacing: 2)),
        ],
      ),
    );
  }

  static pw.Widget _buildCardWithList(PdfColor bg, PdfColor titleColor, PdfColor textColor, String title, List<List<pw.Widget>> items, String svgIcon) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: bg,
        borderRadius: pw.BorderRadius.circular(24),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 24, height: 24,
            margin: const pw.EdgeInsets.only(bottom: 12),
            child: pw.SvgImage(svg: svgIcon.replaceAll('#COLOR_PLACEHOLDER', titleColor.toHex())),
          ),
          pw.Text(title, style: pw.TextStyle(color: titleColor, fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          ...items.expand((item) => [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: item,
            ),
            pw.SizedBox(height: 14),
          ]),
        ],
      ),
    );
  }
}
