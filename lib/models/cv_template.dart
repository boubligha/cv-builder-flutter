import 'package:flutter/material.dart';

class CVTemplate {
  final String name;
  final Color backgroundColor;
  final String description;

  const CVTemplate({
    required this.name,
    required this.backgroundColor,
    required this.description,
  });
}

class CVTemplates {
  static const List<CVTemplate> templates = [
    CVTemplate(
      name: 'Professional Classic',
      backgroundColor: Colors.blue,
      description: 'A clean, traditional layout perfect for most professional fields',
    ),
    CVTemplate(
      name: 'Modern Minimal',
      backgroundColor: Colors.teal,
      description: 'Contemporary design with sleek typography and ample white space',
    ),
    CVTemplate(
      name: 'Creative Portfolio',
      backgroundColor: Colors.purple,
      description: 'Bold design for creative professionals with visual emphasis',
    ),
  ];
} 