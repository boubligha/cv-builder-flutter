import 'package:flutter/material.dart';

class OtherInformationPage extends StatefulWidget {
  const OtherInformationPage({super.key});

  @override
  State<OtherInformationPage> createState() => _OtherInformationPageState();
}

class _OtherInformationPageState extends State<OtherInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create new CV'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Add info action here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                    color: index == 3 ? Colors.black : Colors.grey[300],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Center(
              child: Text(
                'Other Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            const Text('About me'),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText:
                    'I have a clear, logical mind with a practical approach to problem-solving and a drive to see things through to completion. I have more than 2 years of experience in managing and leading...',
              ),
            ),
            const SizedBox(height: 24),

            // Section buttons
            ListTile(
              tileColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text('Languages'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Handle languages section
              },
            ),
            const SizedBox(height: 12),

            ListTile(
              tileColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text('References'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Handle references section
              },
            ),
            const SizedBox(height: 12),

            ListTile(
              tileColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text('Skills'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Handle skills section
              },
            ),
            const SizedBox(height: 12),

            ListTile(
              tileColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text('add custom section'),
              leading: const Icon(Icons.add),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Handle custom section
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
                onPressed: () {
                  // Navigation to next page will go here
                },
                child: const Text('Next step'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
