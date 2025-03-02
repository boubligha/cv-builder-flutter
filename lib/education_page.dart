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

  // Add these lists for dropdown options
  final List<String> _degrees = [
    'High School Diploma',
    'Associate\'s Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctorate (Ph.D.)',
    'MBA',
    'Professional Certification',
    'Other',
  ];

  List<String> _generateYearList() {
    final currentYear = DateTime.now().year;
    return List.generate(50, (index) => (currentYear - index).toString());
  }

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
          builder:
              (context) => OtherInformationPage(
                userInfo: updatedUserInfo,
                selectedTemplate: widget.selectedTemplate,
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final yearsList = _generateYearList();

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
      body: Form(
        key: _formKey,
        child: Column(
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
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'School',
                      ),
                      onSaved: (value) {
                        if (_education.isEmpty) {
                          _education.add({
                            'school': value ?? '',
                            'degree': '',
                            'field': '',
                            'startDate': startDate?.toString() ?? '',
                            'endDate': endDate?.toString() ?? '',
                            'description': '',
                          });
                        } else {
                          _education[0]['school'] = value ?? '';
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter school name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Date selection
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hint: Text('Start Date'),
                            items:
                                yearsList.map((String year) {
                                  return DropdownMenuItem<String>(
                                    value: year,
                                    child: Text(year),
                                  );
                                }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) {
                                  startDate = DateTime(int.parse(value));
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            hint: Text('End Date'),
                            items:
                                [...yearsList, 'Present'].map((String year) {
                                  return DropdownMenuItem<String>(
                                    value: year,
                                    child: Text(year),
                                  );
                                }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null && value != 'Present') {
                                  endDate = DateTime(int.parse(value));
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Subject field
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Subject',
                      ),
                      onSaved: (value) {
                        if (!_education.isEmpty) {
                          _education[0]['field'] = value ?? '';
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    // Degree field
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      hint: Text('Degree'),
                      items:
                          _degrees.map((String degree) {
                            return DropdownMenuItem<String>(
                              value: degree,
                              child: Text(degree),
                            );
                          }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) {
                            if (!_education.isEmpty) {
                              _education[0]['degree'] = value;
                            }
                          }
                        });
                      },
                      onSaved: (value) {
                        if (!_education.isEmpty) {
                          _education[0]['degree'] = value ?? '';
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a degree';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Description field
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText:
                            'Add a description of your course to explain what you learned & satisfied to potential employers',
                      ),
                      onSaved: (value) {
                        if (!_education.isEmpty) {
                          _education[0]['description'] = value ?? '';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Next step button with improved styling
            Container(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Next step',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
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
