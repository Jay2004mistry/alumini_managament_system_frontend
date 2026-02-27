import 'package:flutter/material.dart';
import '../../utils/storage_service.dart';
import '../auth/login_screen.dart';

class FacultyProfileScreen extends StatefulWidget {
  const FacultyProfileScreen({super.key});

  @override
  State<FacultyProfileScreen> createState() =>
      _FacultyProfileScreenState();
}

class _FacultyProfileScreenState extends State<FacultyProfileScreen> {

  bool isEditing = false;

  final TextEditingController nameController =
  TextEditingController(text: "Dr. Rajesh Mehta");

  final TextEditingController departmentController =
  TextEditingController(text: "Computer Science");

  final TextEditingController designationController =
  TextEditingController(text: "Associate Professor");

  final TextEditingController experienceController =
  TextEditingController(text: "12");

  final TextEditingController contactController =
  TextEditingController(text: "+91 9876543210");

  // ================= LOGOUT FUNCTION =================
  Future<void> logout() async {
    await StorageService.logout();

    if (!mounted) return;

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
        title: const Text("Faculty Profile"),
        actions: [

          /// EDIT BUTTON
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),

          /// LOGOUT BUTTON
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            onPressed: logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 55,
              backgroundImage:
              NetworkImage("https://i.pravatar.cc/150?img=12"),
            ),

            const SizedBox(height: 20),

            buildField("Full Name", nameController),
            buildField("Department", departmentController),
            buildField("Designation", designationController),
            buildField("Experience (Years)", experienceController),
            buildField("Contact Number", contactController),

          ],
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: isEditing
          ? TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      )
          : ListTile(
        title: Text(label),
        subtitle: Text(controller.text),
      ),
    );
  }
}