import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: const Center(
        child: Text(
          "Chat Page 💬",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
