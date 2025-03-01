import 'package:flutter/material.dart';
import 'models/cv_template.dart';
import 'education_page.dart';

class WorkExperiencePage extends StatefulWidget {
  final Map<String, dynamic> userInfo;
  final CVTemplate selectedTemplate;

  const WorkExperiencePage({
    super.key,
    required this.userInfo,
    required this.selectedTemplate,
  });

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _experience = {
    'employer': '',
    'startMonth': '',
    'startYear': '',
    'endMonth': '',
    'endYear': '',
    'jobTitle': '',
    'location': '',
    'description': '',
  };

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> _years = List.generate(
    50,
    (index) => (DateTime.now().year - index).toString(),
  );

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final updatedUserInfo = {...widget.userInfo};
      updatedUserInfo['experience'] = _experience;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EducationPage(
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
        title: const Text('Create new CV'),
        actions: const [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 1 ? Colors.black : Colors.grey[300],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Work Experiences'),
              const SizedBox(height: 16),
              
              const Text('Employer'),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'PwC',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employer';
                  }
                  return null;
                },
                onSaved: (value) {
                  _experience['employer'] = value ?? '';
                },
              ),
              const SizedBox(height: 16),

              const Text('Start Date'),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: const Text('Month'),
                        items: _months.map((String month) {
                          return DropdownMenuItem(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _experience['startMonth'] = newValue ?? '';
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 100,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: const Text('Year'),
                        items: _years.map((String year) {
                          return DropdownMenuItem(
                            value: year,
                            child: Text(year),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _experience['startYear'] = newValue ?? '';
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text('End Date'),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: const Text('Month'),
                        items: _months.map((String month) {
                          return DropdownMenuItem(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _experience['endMonth'] = newValue ?? '';
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 100,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        hint: const Text('Year'),
                        items: _years.map((String year) {
                          return DropdownMenuItem(
                            value: year,
                            child: Text(year),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _experience['endYear'] = newValue ?? '';
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text('Job Title'),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Sales Manager',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter job title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _experience['jobTitle'] = value ?? '';
                },
              ),
              const SizedBox(height: 16),

              const Text('Location'),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Jacksonville, FL',
                ),
                onSaved: (value) {
                  _experience['location'] = value ?? '';
                },
              ),
              const SizedBox(height: 16),

              const Text('Description'),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Describe your tasks, responsibilities and any competencies related to this work experience',
                ),
                onSaved: (value) {
                  _experience['description'] = value ?? '';
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
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
                  onPressed: _submitForm,
                  child: const Text('Next step'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
