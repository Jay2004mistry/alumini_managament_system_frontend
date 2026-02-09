import 'package:alumni_management/screens/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // RegisterScreen → tells Flutter “this screen exists”
  //   _RegisterScreenState → holds logic & data
  State<RegisterScreen> createState() => _RegisterScreenState();
}
// This class:---
// -Stores data
// -Handles button click
// -Updates UI
class _RegisterScreenState extends State<RegisterScreen> {

  // This class:----
  // Stores data
  //Handles button click
  //Updates UI
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String role = "ALUMNI"; // default select from dropdown list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Title
      appBar: AppBar(title: const Text("Register")),
      // Adds space from screen edges
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Column = arrange widgets top to bottom.
        child: Column(
          children: [

            TextField(
              // Meaning:-----
              // Text box
              // Label = “Name”
              // Value stored in nameController
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: passwordController,
              // obscureText: true means hides password (***)
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            DropdownButton<String>(
              value: role,
              items: const [
                DropdownMenuItem(value: "ALUMNI", child: Text("ALUMNI")),
                DropdownMenuItem(value: "FACULTY", child: Text("FACULTY")),
                DropdownMenuItem(value: "ADMIN", child: Text("ADMIN"))
              ],

              // onchange if we change value in dropdown it will show
              // if we do not use onchange then it will not update ui
              onChanged: (value) {
                setState(() {
                  role = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // Calls registerUser() method
            ElevatedButton(
              onPressed: registerUser,
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
  // it use to print the user enter data in terminal
  Future<void> registerUser() async {
    final url = Uri.parse("http://192.168.0.104:8080/api/users");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": {
          "roleName": role
        }
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful")),
      );

      // wait a moment so user sees message
      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }

   else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.body}")),
      );
    }
  }

}
