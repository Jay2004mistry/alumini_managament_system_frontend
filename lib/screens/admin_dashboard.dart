import 'package:flutter/material.dart';
import 'base_dashboard.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDashboard(
      body: const Center(
        child: Text("🧑‍💼 Admin Dashboard"),
      ),
    );
  }
}
