import 'dart:convert';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/storage_service.dart';
import '../router/dashboard_router.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final response = await AuthService.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        await StorageService.saveLoginStatus(true);
        await StorageService.saveUserName(data['name']);
        await StorageService.saveUserRole(data['roleName']);

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardRouter()),
        );
      } else {
        _showError("Invalid email or password");
      }

    } catch (e) {
      _showError("Network error. Please try again.");
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                value == null || value.isEmpty ? "Email required" : null,
              ),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) =>
                value == null || value.isEmpty ? "Password required" : null,
              ),

              const SizedBox(height: 20),

              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: loginUser,
                child: const Text("Login"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const RegisterScreen()),
                  );
                },
                child: const Text("Don’t have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
