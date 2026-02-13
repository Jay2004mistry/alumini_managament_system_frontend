import 'package:flutter/material.dart';
import '../../utils/storage_service.dart';
import '../dashboard/admin_home_screen.dart';
import '../dashboard/alumni_home_screen.dart';
import '../dashboard/faculty_home_screen.dart';

class DashboardRouter extends StatefulWidget {
  const DashboardRouter({super.key});

  @override
  State<DashboardRouter> createState() => _DashboardRouterState();
}

class _DashboardRouterState extends State<DashboardRouter> {

  String? role;

  @override
  void initState() {
    super.initState();
    loadRole();
  }

  Future<void> loadRole() async {
    final savedRole = await StorageService.getUserRole();
    setState(() {
      role = savedRole;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (role == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    switch (role) {
      case "ADMIN":
        return const AdminDashboard();
      case "FACULTY":
        return const FacultyDashboard();
      default:
        return const HomeScreen();
    }
  }
}
