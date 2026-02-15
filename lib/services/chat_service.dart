import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../config/api_config.dart';
import '../utils/storage_service.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  StompClient? _stompClient;
  bool _isConnecting = false;
  Function(String)? _onError;
  Function(String)? _onMessageReceived;

  Future<void> connect({
    required String userEmail,
    required Function(String message) onMessageReceived,
    Function(String error)? onError,
  }) async {
    if (_isConnecting) return;
    if (_stompClient != null && _stompClient!.connected) return;

    _isConnecting = true;
    _onError = onError;
    _onMessageReceived = onMessageReceived;

    // 🔥 Get JWT Token
    final token = await StorageService.getToken();

    if (token == null) {
      _onError?.call("Authentication token missing");
      _isConnecting = false;
      return;
    }

    debugPrint("🔐 Using JWT token for WebSocket");

    try {
      _stompClient = StompClient(
        config: StompConfig.sockJS(
          url: "${ApiConfig.baseUrl}/chat",
          heartbeatIncoming: const Duration(seconds: 10),
          heartbeatOutgoing: const Duration(seconds: 10),
          reconnectDelay: const Duration(seconds: 5),

          // 🔥 VERY IMPORTANT
          stompConnectHeaders: {
            "Authorization": "Bearer $token"
          },
          webSocketConnectHeaders: {
            "Authorization": "Bearer $token"
          },

          onConnect: (StompFrame frame) {
            debugPrint("✅ STOMP CONNECTED (JWT Secured)");
            _isConnecting = false;
            _subscribe(userEmail);
          },

          onWebSocketError: (error) {
            debugPrint("❌ WebSocket error: $error");
            _isConnecting = false;
            _stompClient = null;
            _onError?.call("WebSocket error: $error");
          },

          onDisconnect: (frame) {
            debugPrint("🔴 Disconnected");
            _isConnecting = false;
            _stompClient = null;
          },

          onStompError: (frame) {
            debugPrint("❌ STOMP error: ${frame.body}");
            _onError?.call("STOMP error: ${frame.body}");
          },

          onDebugMessage: (msg) {
            debugPrint("🐛 $msg");
          },
        ),
      );

      _stompClient!.activate();

    } catch (e) {
      debugPrint("❌ Connection failed: $e");
      _isConnecting = false;
      _stompClient = null;
      _onError?.call("Connection failed: $e");
    }
  }

  void _subscribe(String userEmail) {
    if (_stompClient == null || !_stompClient!.connected) return;

    final destination = "/user/queue/messages";
    // 🔥 IMPORTANT: DO NOT include email manually
    // Spring automatically resolves user via Principal

    debugPrint("📥 Subscribing to $destination");

    _stompClient!.subscribe(
      destination: destination,
      callback: (frame) {
        if (frame.body != null) {
          debugPrint("📨 Message: ${frame.body}");
          _onMessageReceived?.call(frame.body!);
        }
      },
    );
  }

  void sendMessage({
    required String receiver,
    required String content,
  }) {
    if (_stompClient == null || !_stompClient!.connected) {
      _onError?.call("Not connected");
      return;
    }

    final message = {
      "receiver": receiver,
      "content": content,
    };

    _stompClient!.send(
      destination: "/app/chat.send",
      body: jsonEncode(message),
      headers: {"content-type": "application/json"},
    );

    debugPrint("📤 Message sent");
  }

  void disconnect() {
    _stompClient?.deactivate();
    _stompClient = null;
    _isConnecting = false;
  }

  bool get isConnected => _stompClient?.connected ?? false;
}
