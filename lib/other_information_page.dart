import 'package:flutter/material.dart';
import 'models/cv_template.dart';
import 'final_cv_page.dart';

class OtherInformationPage extends StatefulWidget {
  final Map<String, dynamic> userInfo;
  final CVTemplate selectedTemplate;

  const OtherInformationPage({
    super.key,
    required this.userInfo,
    required this.selectedTemplate,
  });

  @override
  State<OtherInformationPage> createState() => _OtherInformationPageState();
}

class _OtherInformationPageState extends State<OtherInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _skills = [];
  final List<String> _languages = [];
  String _summary = '';

  void _addSkill() {
    setState(() {
      _skills.add('');
    });
  }

  void _addLanguage() {
    setState(() {
      _languages.add('');
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Add other information to userInfo
      final updatedUserInfo = {...widget.userInfo};
      updatedUserInfo['skills'] = _skills.where((skill) => skill.isNotEmpty).toList();
      updatedUserInfo['languages'] = _languages.where((lang) => lang.isNotEmpty).toList();
      updatedUserInfo['summary'] = _summary;

      // Navigate to final CV page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinalCVPage(
            userInfo: updatedUserInfo,
            selectedTemplate: widget.selectedTemplate,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Additional Information'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Professional Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Write a brief summary about yourself...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onSaved: (value) {
                  _summary = value ?? '';
                },
              ),
              const SizedBox(height: 24),

              // Skills section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Skills',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: _addSkill,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Skill'),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _skills.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter skill',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              _skills.removeAt(index);
                            });
                          },
                        ),
                      ),
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          _skills[index] = value;
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Languages section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Languages',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: _addLanguage,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Language'),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter language',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              _languages.removeAt(index);
                            });
                          },
                        ),
                      ),
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          _languages[index] = value;
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Generate CV'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
