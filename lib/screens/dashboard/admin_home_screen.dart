import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  int selectedIndex = 0;

  List<String> menuItems = [
    "Dashboard",
    "Registrations",
    "Posts",
    "Approved",
    "Events"
  ];

  List<Map<String, String>> pendingUsers = [
    {"name": "Rahul Verma", "role": "Alumni", "extra": "Batch 2020"},
    {"name": "Dr. Sharma", "role": "Faculty", "extra": "Computer Science"},
  ];

  List<Map<String, String>> pendingPosts = [
    {"user": "Rahul Verma", "role": "Alumni", "content": "Excited to reconnect!"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),

      body: Row(
        children: [

          /// SIDEBAR
          Container(
            width: 220,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "GLS Admin",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                ...List.generate(menuItems.length, (index) {
                  bool isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.indigo.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 20,
                            color: isSelected
                                ? Colors.indigo
                                : Colors.transparent,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            menuItems[index],
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Colors.indigo
                                  : Colors.black87,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),

          /// CONTENT AREA
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: buildContent(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildContent() {
    switch (selectedIndex) {
      case 0:
        return buildDashboard();
      case 1:
        return buildRegistrations();
      case 2:
        return buildPosts();
      case 3:
        return buildApproved();
      case 4:
        return buildEvents();
      default:
        return buildDashboard();
    }
  }

  ////////////////////////////////////////////////////////////
  /// DASHBOARD
  ////////////////////////////////////////////////////////////

  Widget buildDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Dashboard Overview",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 30),

        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            statCard("Pending Users", pendingUsers.length, Colors.orange),
            statCard("Pending Posts", pendingPosts.length, Colors.blue),
            statCard("Total Events", 4, Colors.indigo),
          ],
        )
      ],
    );
  }

  Widget statCard(String title, int count, Color color) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.grey)),
          const SizedBox(height: 10),
          Text(
            "$count",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color),
          )
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// REGISTRATIONS
  ////////////////////////////////////////////////////////////

  Widget buildRegistrations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Pending Registrations",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: ListView.builder(
            itemCount: pendingUsers.length,
            itemBuilder: (context, index) {
              final user = pendingUsers[index];

              return modernCard(
                title: user["name"]!,
                subtitle:
                "${user["role"]} • ${user["extra"]}",
              );
            },
          ),
        )
      ],
    );
  }

  ////////////////////////////////////////////////////////////
  /// POSTS
  ////////////////////////////////////////////////////////////

  Widget buildPosts() {
    return const Center(
      child: Text(
        "Post Approval Section",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// APPROVED
  ////////////////////////////////////////////////////////////

  Widget buildApproved() {
    return const Center(
      child: Text(
        "Approved Content Section",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// EVENTS
  ////////////////////////////////////////////////////////////

  Widget buildEvents() {
    return const Center(
      child: Text(
        "Event Management Section",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// MODERN CARD
  ////////////////////////////////////////////////////////////

  Widget modernCard({
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle,
              style:
              const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}