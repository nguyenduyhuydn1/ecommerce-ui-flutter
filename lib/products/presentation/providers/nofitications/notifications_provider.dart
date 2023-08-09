import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce_ui_flutter/auth/presentation/providers/auth_provider.dart';
import 'package:ecommerce_ui_flutter/config/constants/enviroments.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_ui_flutter/firebase_options.dart';
import 'package:ecommerce_ui_flutter/products/domain/entities/push_message.dart';

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  final token = ref.watch(authProvider).user?.token;

  return NotificationsNotifier(token: token!);
});

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // print("Handling a background message: ${message.messageId}");
}

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final String token;
  Dio dio = Dio();

  //consstructor
  NotificationsNotifier({required this.token}) : super(NotificationsState()) {
    dio = Dio(
      BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {'Authorization': 'Bearer $token'}),
    );
    _initialStatusCheck();
    loadNextPage();
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print(token);
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    state = state.copyWith(status: settings.authorizationStatus);

    _getFCMToken();
  }

  void loadNextPage() async {
    final res = await dio.get('/notifications');
    final List arr = res.data['notification'];

    final List<PushMessage> notifications = arr.map((message) {
      return PushMessage(
        messageId: '123123213',
        title: message['title'] ?? '',
        body: message['body'] ?? '',
        sentDate: DateTime.now(),
        data: message['productId'],
        imageUrl: message['image'],
      );
    }).toList();
    state = state.copyWith(
        notifications: [...notifications.reversed, ...state.notifications]);
  }

  void handleRemoteMessage(RemoteMessage message) async {
    if (message.notification == null) return;

    final notification = PushMessage(
      messageId:
          message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );

    await dio.post('/notifications', data: {
      "body": message.notification!.body ?? '',
      'title': message.notification!.title ?? '',
      'image': Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
      'productId': message.data
    });

    state =
        state.copyWith(notifications: [notification, ...state.notifications]);
  }

  void requestPermistion() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    state = state.copyWith(status: settings.authorizationStatus);
    _getFCMToken();
  }
}

class NotificationsState {
  final AuthorizationStatus status;
  final List<PushMessage> notifications;
  NotificationsState({
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const [],
  });

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
  }) =>
      NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
      );
}

//   PushMessage? getMessageById(String pushMessageId) {
//     final messId = state.notifications
//         .indexWhere((element) => element.messageId == pushMessageId);
//     if (messId == -1) return null;

//     // return state.notifications[messId];
//     return state.notifications
//         .firstWhere((element) => element.messageId == pushMessageId);
//   }
// }
