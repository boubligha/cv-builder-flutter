import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CVTemplate {
  final String name;
  final String thumbnailPath;
  final String category;
  final bool isFavorite;

  CVTemplate({
    required this.name,
    required this.thumbnailPath,
    required this.category,
    this.isFavorite = false,
  });

  CVTemplate copyWith({
    String? name,
    String? thumbnailPath,
    String? category,
    bool? isFavorite,
  }) {
    return CVTemplate(
      name: name ?? this.name,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  static List<CVTemplate> templates = [];
  static List<String> categories = ['ALL', 'Favorites'];

  static Future<void> loadTemplates() async {
    try {
      // List all files in assets/templates directory
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      
      // Filter for template files
      final templatePaths = manifestMap.keys
          .where((String key) => key.startsWith('assets/templates/'))
          .toList();

      templates = templatePaths.map((path) {
        // Extract template name from path (remove extension and directory)
        final name = path.split('/').last.split('.').first;
        // Capitalize first letter and add spaces before capital letters
        final formattedName = name.substring(0, 1).toUpperCase() +
            name.substring(1).replaceAllMapped(
                RegExp(r'([A-Z])'), (Match m) => ' ${m[1]}');

        return CVTemplate(
          name: formattedName,
          thumbnailPath: path,
          category: 'Template', // You can modify this based on your needs
        );
      }).toList();

      // Sort templates by name
      templates.sort((a, b) => a.name.compareTo(b.name));
      
      // Add 'Template' category if we have templates
      if (templates.isNotEmpty && !categories.contains('Template')) {
        categories.add('Template');
      }
    } catch (e) {
      print('Error loading templates: $e');
    }
  }
} 