import 'package:flutter/material.dart';
import 'base_dashboard.dart';

class AlumniDashboard extends StatelessWidget {
  const AlumniDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDashboard(
      body: const Center(
        child: Text("🎓 Alumni Dashboard"),
      ),
    );
  }
}
