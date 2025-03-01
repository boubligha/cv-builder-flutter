import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PDFGenerator {
  static Future<File> generateCV(Map<String, dynamic> userData, String templateStyle) async {
    final pdf = pw.Document();

    // Get user data
    final contactInfo = userData['contactInfo'] ?? {};
    final education = userData['education'] ?? [];
    final experience = userData['experience'] ?? [];
    final skills = userData['skills'] ?? [];
    final profileImage = userData['profileImage'];

    // Create PDF based on template style
    switch (templateStyle) {
      case 'modern':
        await _generateModernTemplate(
          pdf,
          contactInfo,
          education,
          experience,
          skills,
          profileImage,
        );
        break;
      case 'professional':
        await _generateProfessionalTemplate(
          pdf,
          contactInfo,
          education,
          experience,
          skills,
          profileImage,
        );
        break;
      // Add more template styles as needed
      default:
        await _generateDefaultTemplate(
          pdf,
          contactInfo,
          education,
          experience,
          skills,
          profileImage,
        );
    }

    // Save the PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/cv.pdf');
    await file.writeAsBytes(await pdf.save());
    
    return file;
  }

  static Future<void> _generateModernTemplate(
    pw.Document pdf,
    Map<String, dynamic> contactInfo,
    List<dynamic> education,
    List<dynamic> experience,
    List<dynamic> skills,
    String? profileImage,
  ) async {
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header with contact info
              pw.Container(
                color: PdfColors.grey800,
                padding: const pw.EdgeInsets.all(20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${contactInfo['firstName']} ${contactInfo['lastName']}',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      contactInfo['email'] ?? '',
                      style: pw.TextStyle(color: PdfColors.white),
                    ),
                    pw.Text(
                      contactInfo['phone'] ?? '',
                      style: pw.TextStyle(color: PdfColors.white),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Education Section
              pw.Text(
                'Education',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              ...education.map((edu) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    edu['school'] ?? '',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text('${edu['degree']} in ${edu['subject']}'),
                  pw.Text('${edu['startDate']} - ${edu['endDate']}'),
                  pw.Text(edu['description'] ?? ''),
                  pw.SizedBox(height: 10),
                ],
              )),

              pw.SizedBox(height: 20),

              // Experience Section
              pw.Text(
                'Experience',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              ...experience.map((exp) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    exp['company'] ?? '',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(exp['position'] ?? ''),
                  pw.Text('${exp['startDate']} - ${exp['endDate']}'),
                  pw.Text(exp['description'] ?? ''),
                  pw.SizedBox(height: 10),
                ],
              )),

              // Skills Section
              pw.Text(
                'Skills',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              pw.Wrap(
                spacing: 10,
                runSpacing: 5,
                children: skills.map((skill) => pw.Container(
                  padding: const pw.EdgeInsets.all(5),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text(skill.toString()),
                )).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  // Add more template generation methods as needed
  static Future<void> _generateProfessionalTemplate(
    pw.Document pdf,
    Map<String, dynamic> contactInfo,
    List<dynamic> education,
    List<dynamic> experience,
    List<dynamic> skills,
    String? profileImage,
  ) async {
    // Implement professional template
  }

  static Future<void> _generateDefaultTemplate(
    pw.Document pdf,
    Map<String, dynamic> contactInfo,
    List<dynamic> education,
    List<dynamic> experience,
    List<dynamic> skills,
    String? profileImage,
  ) async {
    // Implement default template
  }
} 