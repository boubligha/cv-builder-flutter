import 'package:flutter/material.dart';
import 'models/cv_template.dart';
import 'template_preview_page.dart';

class ViewTemplatesPage extends StatefulWidget {
  const ViewTemplatesPage({super.key});

  @override
  State<ViewTemplatesPage> createState() => _ViewTemplatesPageState();
}

class _ViewTemplatesPageState extends State<ViewTemplatesPage> {
  String selectedCategory = 'ALL';
  List<CVTemplate> filteredTemplates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    setState(() => isLoading = true);
    await CVTemplate.loadTemplates();
    setState(() {
      filteredTemplates = CVTemplate.templates;
      isLoading = false;
    });
  }

  void filterTemplates(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'Favorites') {
        filteredTemplates =
            CVTemplate.templates.where((t) => t.isFavorite).toList();
      } else if (category == 'ALL') {
        filteredTemplates = CVTemplate.templates;
      } else {
        filteredTemplates =
            CVTemplate.templates.where((t) => t.category == category).toList();
      }
    });
  }

  void _handleTemplateFavoriteChanged(CVTemplate updatedTemplate) {
    setState(() {
      final index = CVTemplate.templates.indexOf(updatedTemplate);
      if (index != -1) {
        CVTemplate.templates[index] = updatedTemplate;
        final filteredIndex = filteredTemplates.indexOf(updatedTemplate);
        if (filteredIndex != -1) {
          filteredTemplates[filteredIndex] = updatedTemplate;
        }
      }
      if (selectedCategory == 'Favorites') {
        filterTemplates('Favorites');
      }
    });
  }

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
            icon: Icon(
              Icons.favorite,
              color: selectedCategory == 'Favorites' ? Colors.red : null,
            ),
            onPressed: () {
              filterTemplates('Favorites');
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Add info action
            },
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children:
                          CVTemplate.categories.map((category) {
                            return _buildCategoryChip(
                              category,
                              isSelected: selectedCategory == category,
                            );
                          }).toList(),
                    ),
                  ),
                  Expanded(
                    child:
                        filteredTemplates.isEmpty
                            ? const Center(child: Text('No templates found'))
                            : GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 0.7,
                                  ),
                              itemCount: filteredTemplates.length,
                              itemBuilder: (context, index) {
                                final template = filteredTemplates[index];
                                return _buildTemplateCard(template);
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
          if (selected) {
            filterTemplates(label);
          }
        },
      ),
    );
  }

  Widget _buildTemplateCard(CVTemplate template) {
    return Card(
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => TemplatePreviewPage(
                        template: template,
                        onTemplateFavoriteChanged:
                            _handleTemplateFavoriteChanged,
                      ),
                ),
              ).then((selectedTemplate) {
                if (selectedTemplate != null) {
                  Navigator.pop(context, selectedTemplate);
                }
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.asset(
                      template.thumbnailPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    template.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                template.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: template.isFavorite ? Colors.red : Colors.grey[700],
              ),
              onPressed: () {
                setState(() {
                  final updatedTemplate = template.copyWith(
                    isFavorite: !template.isFavorite,
                  );
                  final index = CVTemplate.templates.indexOf(template);
                  if (index != -1) {
                    CVTemplate.templates[index] = updatedTemplate;
                    final filteredIndex = filteredTemplates.indexOf(template);
                    if (filteredIndex != -1) {
                      filteredTemplates[filteredIndex] = updatedTemplate;
                    }
                  }
                  if (selectedCategory == 'Favorites') {
                    filterTemplates('Favorites');
                  }
                });
              },
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.add_circle),
              color: Colors.grey[700],
              onPressed: () {
                Navigator.pop(context, template);
              },
            ),
          ),
        ],
      ),
    );
  }
}
