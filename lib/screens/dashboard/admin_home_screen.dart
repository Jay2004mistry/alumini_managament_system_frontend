import 'package:flutter/material.dart';
import '../../utils/storage_service.dart';
import '../auth/login_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  Future<void> _logout(BuildContext context) async {
    await StorageService.logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome Admin 👨‍💼",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
