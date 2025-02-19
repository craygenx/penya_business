import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationNotifier extends StateNotifier<List<RemoteMessage>>{
  NotificationNotifier(): super([]);

  void addNotification(RemoteMessage message){
    state = [...state, message];
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, List<RemoteMessage>>((ref) => NotificationNotifier());