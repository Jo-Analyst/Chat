import 'package:chat/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  int get itemsCount {
    return _items.length;
  }

  List<ChatNotification> get items {
    return [..._items];
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  // Push Notification
  Future<void> init() async {
    await _configureForeground();
  }

  Future<bool> get _isAuthorirized async {
    final messaging = FirebaseMessaging.instance;
    final setting = await messaging.requestPermission();
    return setting.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorirized) {
      FirebaseMessaging.onMessage.listen((msg) {
        if (msg.notification == null) return;
        add(ChatNotification(
          title: msg.notification!.title ?? "Não informado!",
          body: msg.notification!.body ?? "Não informado!",
        ));
      });
    }
  }
}
