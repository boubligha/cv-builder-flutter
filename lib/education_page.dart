import 'package:flutter/material.dart';
import 'models/cv_template.dart';
import 'other_information_page.dart';

class EducationPage extends StatefulWidget {
  final Map<String, dynamic> userInfo;
  final CVTemplate selectedTemplate;

  const EducationPage({
    super.key,
    required this.userInfo,
    required this.selectedTemplate,
  });

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> _education = [];
  DateTime? startDate;
  DateTime? endDate;

  void _addEducation() {
    setState(() {
      _education.add({
        'school': '',
        'degree': '',
        'field': '',
        'startDate': '',
        'endDate': '',
        'description': '',
      });
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Add education to userInfo
      final updatedUserInfo = {...widget.userInfo};
      updatedUserInfo['education'] = _education;

      // Navigate to other information page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtherInformationPage(
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create new CV'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Show info dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 2 ? Colors.black : Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Education Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  // School field
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'School',
                    ),
                  ),
                  SizedBox(height: 16),
                  // Date selection
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          hint: Text('Start Date'),
                          items: [], // Add your date items
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          hint: Text('End Date'),
                          items: [], // Add your date items
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Subject field
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Subject',
                    ),
                  ),
                  SizedBox(height: 16),
                  // Degree field
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    hint: Text('Degree'),
                    items: [], // Add your degree items
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 16),
                  // Description field
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Add a description of your course to explain what you learned & satisfied to potential employers',
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Next step button
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to next page
                Navigator.pushNamed(context, '/other_information');
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Next step',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'School/University'),
              onSaved: (value) {
                _education[index]['school'] = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter school name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Degree'),
              onSaved: (value) {
                _education[index]['degree'] = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter degree';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Field of Study'),
              onSaved: (value) {
                _education[index]['field'] = value ?? '';
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Start Date'),
                    onSaved: (value) {
                      _education[index]['startDate'] = value ?? '';
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'End Date'),
                    onSaved: (value) {
                      _education[index]['endDate'] = value ?? '';
                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              onSaved: (value) {
                _education[index]['description'] = value ?? '';
              },
            ),
          ],
        ),
      ),
    );
  }
} 