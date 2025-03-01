import 'package:flutter/material.dart';
import 'models/cv_template.dart';
import 'template_preview_page.dart';

class ViewTemplatesPage extends StatelessWidget {
  const ViewTemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('View Templates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Add info action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _buildCategoryChip('ALL', isSelected: true),
                _buildCategoryChip('Formal'),
                _buildCategoryChip('Artistic'),
                _buildCategoryChip('Black & White'),
                _buildCategoryChip('New'),
              ],
            ),
          ),
          // Templates grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 4, // Number of template cards
              itemBuilder: (context, index) {
                return _buildTemplateCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          // Add category selection logic
        },
      ),
    );
  }

  Widget _buildTemplateCard() {
    return Card(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Icon(Icons.star_border, color: Colors.grey[700]),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Icon(Icons.remove_red_eye, color: Colors.grey[700]),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Icon(Icons.add_circle, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
