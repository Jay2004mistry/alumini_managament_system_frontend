import 'package:flutter/material.dart';

import 'notification_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [

          NotificationCard(
            title: "Event Joined",
            message: "You successfully joined Flutter Workshop.",
            time: "2 hours ago",
          ),

          NotificationCard(
            title: "New Event Posted",
            message: "Alumni Meet 2024 has been announced.",
            time: "Yesterday",
          ),

          NotificationCard(
            title: "Reminder",
            message: "Networking Night starts tomorrow.",
            time: "2 days ago",
          ),
        ],
      ),
    );
  }
}