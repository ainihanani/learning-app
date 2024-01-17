import 'package:flutter/material.dart';

class LearningBasePage extends StatelessWidget {
  const LearningBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Learning Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This is the AR Learning Page',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button press action if needed
                // For example, you can navigate to another page or perform other actions
              },
              child: const Text('Button without Unity'),
            ),
          ],
        ),
      ),
    );
  }
}
