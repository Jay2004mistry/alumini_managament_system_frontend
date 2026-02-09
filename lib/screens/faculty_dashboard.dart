import 'package:flutter/material.dart';
import 'base_dashboard.dart';

class FacultyDashboard extends StatelessWidget {
  const FacultyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDashboard(
      body: const Center(
        child: Text("🧑‍🏫 Faculty Dashboard"),
      ),
    );
  }
}
