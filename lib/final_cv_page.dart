import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'models/cv_template.dart';

class FinalCVPage extends StatefulWidget {
  final Map<String, dynamic> userInfo;
  final CVTemplate selectedTemplate;

  const FinalCVPage({
    super.key,
    required this.userInfo,
    required this.selectedTemplate,
  });

  @override
  State<FinalCVPage> createState() => _FinalCVPageState();
}

class _FinalCVPageState extends State<FinalCVPage> {
  bool isGenerating = false;

  Future<void> _generateAndDownloadPDF() async {
    setState(() => isGenerating = true);
    try {
      final pdf = pw.Document();

      // Add pages based on selected template
      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Column(
              children: [
                if (widget.userInfo['profileImage'] != null)
                  pw.Container(
                    width: 100,
                    height: 100,
                    child: pw.Image(
                      pw.MemoryImage(
                        File(widget.userInfo['profileImage']).readAsBytesSync(),
                      ),
                    ),
                  ),
                pw.Text(
                  '${widget.userInfo['firstName']} ${widget.userInfo['lastName']}',
                  style: pw.TextStyle(fontSize: 24),
                ),
                pw.SizedBox(height: 20),
                pw.Text(widget.userInfo['email'] ?? ''),
                pw.Text(widget.userInfo['phone'] ?? ''),
                if (widget.userInfo['address'] != null)
                  pw.Text(widget.userInfo['address']),
                if (widget.userInfo['zipCode'] != null || widget.userInfo['city'] != null)
                  pw.Text('${widget.userInfo['zipCode'] ?? ''} ${widget.userInfo['city'] ?? ''}'),
              ],
            );
          },
        ),
      );

      // Get the downloads directory
      final directory = await getExternalStorageDirectory();
      final downloadPath = '${directory?.path}/Download';
      // Create the directory if it doesn't exist
      await Directory(downloadPath).create(recursive: true);
      
      final file = File('$downloadPath/my_cv.pdf');
      await file.writeAsBytes(await pdf.save());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CV saved to Downloads folder')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating CV: $e')),
        );
      }
    } finally {
      setState(() => isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your CV'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Preview of the CV
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      widget.selectedTemplate.thumbnailPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Display some user information
                  Text(
                    '${widget.userInfo['firstName']} ${widget.userInfo['lastName']}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(widget.userInfo['email'] ?? ''),
                  Text(widget.userInfo['phone'] ?? ''),
                  // Add more user information display
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: isGenerating ? null : _generateAndDownloadPDF,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: isGenerating
                  ? const CircularProgressIndicator()
                  : const Text('Download PDF'),
            ),
          ),
        ],
      ),
    );
  }
} 