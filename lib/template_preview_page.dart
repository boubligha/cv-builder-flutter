import 'package:cursortest/models/cv_template.dart';
import 'package:flutter/material.dart';

class TemplatePreviewPage extends StatelessWidget {
  const TemplatePreviewPage({super.key, required CVTemplate template});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Template Preview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // PDF Preview placeholder
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                // Here you would integrate a PDF viewer
                child: const Center(child: Text('PDF Template Preview')),
              ),
            ),
            // Use template button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Handle template selection
                  },
                  child: const Text('Use this template'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
