import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "GLS Connect",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// ================= ANNOUNCEMENTS =================
          const Text(
            "Faculty Announcements",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: buildAnnouncementCard(index),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          /// ================= POSTS =================
          const Text(
            "Recent Posts",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 16),

          ...List.generate(12, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: buildPostCard(index),
            );
          }),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// ================= ANNOUNCEMENT CARD =================
  Widget buildAnnouncementCard(int index) {
    final colors = [
      const Color(0xFFFFF4E6),
      const Color(0xFFE6F4FF),
      const Color(0xFFE8F5E9),
    ];

    return Container(
      width: 260,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors[index % 3],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Chip(
            label: const Text("Official"),
            backgroundColor: Colors.black,
            labelStyle: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            "Event ${index + 1}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Register now for this amazing opportunity happening soon!",
            style: TextStyle(fontSize: 13),
          ),
          const Spacer(),
          const Text(
            "Feb 20, 2026",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// ================= POST CARD =================
  Widget buildPostCard(int index) {
    bool hasImage = index % 2 == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ================= HEADER =================
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const CircleAvatar(radius: 20),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rahul Verma ${index + 1}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        "Batch 2022 • 2 hours ago",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.more_vert),
              ],
            ),
          ),

          /// ================= IMAGE =================
          if (hasImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                "https://picsum.photos/500/350?random=$index",
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          /// ================= ACTION BUTTONS =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: const [
                Icon(Icons.favorite_border),
                SizedBox(width: 16),
                Icon(Icons.comment_outlined),
                SizedBox(width: 16),
                Icon(Icons.share_outlined),
                Spacer(),
                Icon(Icons.bookmark_border),
              ],
            ),
          ),

          /// ================= LIKES COUNT =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              "234 likes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// ================= CAPTION =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "Rahul Verma ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                    "Excited to share my achievement with GLS community! 🚀",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              "View all 45 comments",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
