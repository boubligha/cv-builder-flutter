import 'package:flutter/material.dart';
import 'models/cv_template.dart';
import 'services/pdf_generator.dart';
import 'package:printing/printing.dart';

class TemplatePreviewPage extends StatefulWidget {
  final CVTemplate template;
  final Function(CVTemplate) onTemplateFavoriteChanged;
  final Map<String, dynamic> userInfo;

  const TemplatePreviewPage({
    super.key,
    required this.template,
    required this.onTemplateFavoriteChanged,
    required this.userInfo,
  });

  @override
  State<TemplatePreviewPage> createState() => _TemplatePreviewPageState();
}

class _TemplatePreviewPageState extends State<TemplatePreviewPage> {
  late CVTemplate currentTemplate;

  @override
  void initState() {
    super.initState();
    currentTemplate = widget.template;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentTemplate.name),
        actions: [
          IconButton(
            icon: Icon(
              currentTemplate.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: currentTemplate.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              final updatedTemplate = currentTemplate.copyWith(
                isFavorite: !currentTemplate.isFavorite,
              );
              setState(() {
                currentTemplate = updatedTemplate;
              });
              widget.onTemplateFavoriteChanged(updatedTemplate);
            },
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, currentTemplate);
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadPDF,
          ),
        ],
      ),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: Image.asset(
            currentTemplate.thumbnailPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Future<void> _downloadPDF() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      // Generate PDF
      final pdfFile = await PDFGenerator.generateCV(
        widget.userInfo,
        currentTemplate.style,
      );

      // Hide loading indicator
      Navigator.pop(context);

      // Show PDF preview and download options
      await Printing.layoutPdf(
        onLayout: (_) async => pdfFile.readAsBytesSync(),
      );
    } catch (e) {
      // Hide loading indicator
      Navigator.pop(context);
      
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }
}
