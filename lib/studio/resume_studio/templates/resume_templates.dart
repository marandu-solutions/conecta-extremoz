import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:conecta/models/worker/resume_model.dart';

import 'template_moderno.dart';
import 'template_classico.dart';
import 'template_minimalista.dart';
import 'template_tech.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

enum ResumeTemplate { modern, classic, minimalist, tech }

class ResumeTemplates {
  static Future<pw.Document> generate(
      ResumeModel resume, ResumeTemplate template) async {
    final pdf = pw.Document();

    Uint8List? profileImage;
    if (template == ResumeTemplate.tech) {
      try {
        final data = await rootBundle.load('assets/images/image.png');
        profileImage = data.buffer.asUint8List();
      } catch (e) {
        // Se a imagem não for encontrada, profileImage será null
      }
    }

    switch (template) {
      case ResumeTemplate.modern:
        pdf.addPage(TemplateModerno.build(resume));
        break;
      case ResumeTemplate.classic:
        pdf.addPage(TemplateClassico.build(resume));
        break;
      case ResumeTemplate.minimalist:
        pdf.addPage(TemplateMinimalista.build(resume));
        break;
      case ResumeTemplate.tech:
        pdf.addPage(TemplateTech.build(resume, profileImage));
        break;
    }

    return pdf;
  }
}
