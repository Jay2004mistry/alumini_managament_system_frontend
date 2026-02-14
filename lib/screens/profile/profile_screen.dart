import 'package:flutter/material.dart';
import '../../utils/storage_service.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isEditing = false;

  final TextEditingController nameController =
  TextEditingController(text: "Priya Sharma");

  final TextEditingController bioController =
  TextEditingController(text:
  "Computer Science student passionate about AI and Machine Learning. Actively seeking internships in tech.");

  final TextEditingController locationController =
  TextEditingController(text: "Ahmedabad, India");

  final TextEditingController batchController =
  TextEditingController(text: "Batch 2024 • GLS University");

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
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [

          /// EDIT BUTTON
          IconButton(
            icon: Icon(
              isEditing ? Icons.check : Icons.edit,
              color: const Color(0xFF3A86FF),
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),

          /// LOGOUT ICON
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
        child: Column(
          children: [

            /// HEADER
            Container(
              width: double.infinity,
              height: 140,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3A86FF), Color(0xFF4D9CFF)],
                ),
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -50),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=5"),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isEditing
                  ? TextField(controller: nameController)
                  : Text(
                nameController.text,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isEditing
                  ? TextField(controller: batchController)
                  : Text(
                batchController.text,
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            /// STATS
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileStat(number: "245", label: "Connections"),
                  ProfileStat(number: "38", label: "Posts"),
                  ProfileStat(number: "5", label: "Communities"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            sectionTitle("About"),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isEditing
                  ? TextField(
                controller: bioController,
                maxLines: 3,
              )
                  : Text(bioController.text),
            ),

            const SizedBox(height: 25),

            sectionTitle("Location"),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: isEditing
                  ? TextField(controller: locationController)
                  : Row(
                children: [
                  const Icon(Icons.location_on,
                      size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(locationController.text),
                ],
              ),
            ),

            const SizedBox(height: 30),

            sectionTitle("Your Posts"),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://picsum.photos/300/300?random=$index",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String number;
  final String label;

  const ProfileStat({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 12),
        ),
      ],
    );
  }
}
