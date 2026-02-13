import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        title: const Text(
          "GLS Connect",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [

            // ================= FACULTY SECTION (FIXED) =================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Faculty Announcements",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 190,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: buildFacultyCard(
                            title: index == 0
                                ? "National Hackathon 2026"
                                : index == 1
                                ? "Summer Internship Drive"
                                : "AI Workshop 2026",
                            subtitle:
                            "Register now for this amazing opportunity!",
                            tag: index == 0
                                ? "Hackathon"
                                : index == 1
                                ? "Internship"
                                : "Workshop",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ================= POSTS SECTION (SCROLLABLE) =================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                children: [

                  const Text(
                    "Recent Posts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  buildPostCard(
                    name: "Rahul Verma",
                    subtitle: "Batch 2020 • 2 hours ago",
                    category: "Achievement",
                    content:
                    "Excited to share that I have been promoted to Senior Software Engineer at Google!",
                    showImage: false,
                  ),

                  const SizedBox(height: 16),

                  buildPostCard(
                    name: "Dr. Anjali Desai",
                    subtitle: "4 hours ago",
                    category: "Event",
                    content:
                    "Reminder: Guest lecture tomorrow at 3 PM in Auditorium B.",
                    showImage: true,
                  ),

                  const SizedBox(height: 16),

                  buildPostCard(
                    name: "Amit Shah",
                    subtitle: "Batch 2022 • 1 day ago",
                    category: "Startup",
                    content:
                    "Happy to launch my new AI-based startup!",
                    showImage: false,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF1C1C1E),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(Icons.home, 0),
              buildNavItem(Icons.group, 1),
              const SizedBox(width: 40),
              buildNavItem(Icons.message_outlined, 2),
              buildNavItem(Icons.person_outline, 3),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3A86FF),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
    );
  }

  // ================= FACULTY CARD =================
  Widget buildFacultyCard({
    required String title,
    required String subtitle,
    required String tag,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Chip(
            label: Text(tag),
            backgroundColor: const Color(0xFF3A86FF),
            labelStyle:
            const TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ================= POST CARD =================
  Widget buildPostCard({
    required String name,
    required String subtitle,
    required String category,
    required String content,
    required bool showImage,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Chip(
                label: Text(category),
                backgroundColor: const Color(0xFF2A2A2D),
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            content,
            style: const TextStyle(color: Colors.grey),
          ),

          if (showImage) ...[
            const SizedBox(height: 12),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],

          const SizedBox(height: 12),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.favorite_border, color: Colors.grey),
              Icon(Icons.comment_outlined, color: Colors.grey),
              Icon(Icons.share_outlined, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  // ================= NAV ITEM =================
  Widget buildNavItem(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
      icon: Icon(
        icon,
        color: selectedIndex == index
            ? const Color(0xFF3A86FF)
            : Colors.grey,
      ),
    );
  }
}
