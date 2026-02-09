import 'package:flutter/material.dart';

class AlumniDashboard extends StatelessWidget {
  const AlumniDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alumni Dashboard")),
      body: const Center(
        child: Text(
          "🎓 Welcome Alumni",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
