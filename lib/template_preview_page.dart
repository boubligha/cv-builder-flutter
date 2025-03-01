import 'package:flutter/material.dart';
import 'models/cv_template.dart';

class TemplatePreviewPage extends StatefulWidget {
  final CVTemplate template;
  final Function(CVTemplate) onTemplateFavoriteChanged;

  const TemplatePreviewPage({
    super.key,
    required this.template,
    required this.onTemplateFavoriteChanged,
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
}
