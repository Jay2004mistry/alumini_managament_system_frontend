import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import '../../services/chat_service.dart';
import '../../utils/storage_service.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String receiverEmail;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.receiverEmail,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];
  final ChatService _chatService = ChatService();

  String? myEmail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initChat();
  }

  Future<void> initChat() async {
    myEmail = await StorageService.getUserEmail();
    final token = await StorageService.getToken();

    if (myEmail == null || token == null) return;

    await loadChatHistory(token);

    _chatService.connect(
      userEmail: myEmail!,
      onMessageReceived: (message) {
        final decoded = jsonDecode(message);

        // 🔥 IMPORTANT: Only check by id (safe duplicate prevention)
        bool exists =
        messages.any((msg) => msg["id"] == decoded["id"]);

        if (!exists) {
          setState(() {
            messages.add({
              "id": decoded["id"],
              "text": decoded["content"],
              "isMe": decoded["sender"] == myEmail,
              "timestamp": decoded["timestamp"],
            });
          });
        }
      },
    );

    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadChatHistory(String token) async {
    final response = await http.get(
      Uri.parse(
          "${ApiConfig.baseUrl}/api/chat/history/${widget.receiverEmail}"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      setState(() {
        messages.clear();
        messages.addAll(data.map((msg) {
          return {
            "id": msg["id"],
            "text": msg["content"],
            "isMe": msg["sender"] == myEmail,
            "timestamp": msg["timestamp"],
          };
        }).toList());
      });
    }
  }

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    _chatService.sendMessage(
      receiver: widget.receiverEmail,
      content: controller.text.trim(),
    );

    controller.clear();
  }

  @override
  void dispose() {
    controller.dispose();

    // 🔥 VERY IMPORTANT
    _chatService.disconnect();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : messages.isEmpty
                ? Center(
              child: Text(
                "No messages yet",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            )
                : ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg =
                messages[messages.length - 1 - index];
                final isMe = msg["isMe"];

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color(0xFF0066FF)
                          : const Color(0xFFF2F2F2),
                      borderRadius:
                      BorderRadius.circular(16),
                    ),
                    child: Text(
                      msg["text"],
                      style: TextStyle(
                        color: isMe
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFEAEAEA)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Color(0xFF0066FF)),
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
