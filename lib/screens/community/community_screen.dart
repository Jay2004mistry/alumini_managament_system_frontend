import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        title: const Text(
          "Community",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: const Center(
        child: Text(
          "Community Page 👥",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
