import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alumni_dashboard.dart';
import 'faculty_dashboard.dart';
import 'admin_dashboard.dart';

class DashboardRouter extends StatefulWidget {
  const DashboardRouter({super.key});

  @override
  State<DashboardRouter> createState() => _DashboardRouterState();
}

class _DashboardRouterState extends State<DashboardRouter> {
  String role = "";

  @override
  void initState() {
    super.initState();
    loadRole();
  }

  Future<void> loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('userRole') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (role.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (role == "ADMIN") {
      return const AdminDashboard();
    } else if (role == "FACULTY") {
      return const FacultyDashboard();
    } else {
      return const AlumniDashboard();
    }
  }
}
