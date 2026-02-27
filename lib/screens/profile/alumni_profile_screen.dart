import 'package:flutter/material.dart';
import '../../services/alumni_profile_service.dart';
import '../../models/alumni_profile_model.dart';
import '../../utils/storage_service.dart';
import '../auth/login_screen.dart';

class AlumniProfileScreen extends StatefulWidget {
  const AlumniProfileScreen({super.key});

  @override
  State<AlumniProfileScreen> createState() => _AlumniProfileScreenState();
}

class _AlumniProfileScreenState extends State<AlumniProfileScreen> {
  bool isEditing = false;
  bool isLoading = true;

  String username = "";

  final batchController = TextEditingController();
  final degreeController = TextEditingController();
  final departmentController = TextEditingController();
  final designationController = TextEditingController();
  final companyController = TextEditingController();
  final industryController = TextEditingController();
  final skillsController = TextEditingController();
  final expController = TextEditingController();
  final linkedInController = TextEditingController();
  final githubController = TextEditingController();
  final contactController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  Future<void> loadAllData() async {
    await loadUserName();
    await loadProfile();

    setState(() {
      isLoading = false;
    });
  }

  /// ✅ Get username from local storage (saved during login)
  Future<void> loadUserName() async {
    final name = await StorageService.getUserName();
    username = name ?? "";
  }

  Future<void> loadProfile() async {
    final profile = await AlumniProfileService.getProfile();

    if (profile != null) {
      batchController.text = profile.batchYear?.toString() ?? "";
      degreeController.text = profile.degree ?? "";
      departmentController.text = profile.department ?? "";
      designationController.text = profile.designation ?? "";
      companyController.text = profile.companyName ?? "";
      industryController.text = profile.industry ?? "";
      skillsController.text = profile.skills ?? "";
      expController.text = profile.workExperience?.toString() ?? "";
      linkedInController.text = profile.linkedInUrl ?? "";
      githubController.text = profile.githubUrl ?? "";
      contactController.text = profile.contactNumber ?? "";
      cityController.text = profile.currentCity ?? "";
    }
  }

  Future<void> saveProfile() async {
    final updatedProfile = AlumniProfileModel(
      batchYear: int.tryParse(batchController.text),
      degree: degreeController.text,
      department: departmentController.text,
      designation: designationController.text,
      companyName: companyController.text,
      industry: industryController.text,
      skills: skillsController.text,
      workExperience: double.tryParse(expController.text),
      linkedInUrl: linkedInController.text,
      githubUrl: githubController.text,
      contactNumber: contactController.text,
      currentCity: cityController.text,
    );

    final success =
    await AlumniProfileService.updateProfile(updatedProfile);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated")),
      );
    }
  }

  Future<void> _handleLogout() async {
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
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Alumni Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.save_outlined : Icons.edit_outlined,
              color: Colors.black,
            ),
            onPressed: () async {
              if (isEditing) {
                await saveProfile();
              }
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined,
                color: Colors.black87),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [

            /// 🔥 Profile Image + Username
            Column(
              children: [
                const CircleAvatar(
                  radius: 56,
                  backgroundColor: Color(0xFFF5F5F5),
                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 56,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  username.isEmpty ? "User" : username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            _buildCard("Academic Information", [
              _buildField('Batch Year', batchController),
              _buildField('Degree', degreeController),
              _buildField('Department', departmentController),
            ]),

            _buildCard("Professional Information", [
              _buildField('Designation', designationController),
              _buildField('Company Name', companyController),
              _buildField('Industry', industryController),
              _buildField('Skills', skillsController,
                  isMultiline: true),
              _buildField('Work Experience', expController),
            ]),

            _buildCard("Contact Information", [
              _buildField('LinkedIn URL', linkedInController),
              _buildField('GitHub URL', githubController),
              _buildField('Contact Number', contactController),
              _buildField('Current City', cityController),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: isEditing
          ? TextField(
        controller: controller,
        maxLines: isMultiline ? 3 : 1,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            controller.text.isEmpty ? '-' : controller.text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}