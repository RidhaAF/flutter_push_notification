import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtrl = StreamController<String>.broadcast();
  final titleCtrl = StreamController<String>.broadcast();
  final bodyCtrl = StreamController<String>.broadcast();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.data.containsKey('data')) {
        // Handle data message
        streamCtrl.sink.add(message.data['data']);
      }

      if (message.data.containsKey('notification')) {
        // Handle notification message
        streamCtrl.sink.add(message.data['notification']);
      }

      titleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });

    final token =
        _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  dispose() {
    streamCtrl.close();
    titleCtrl.close();
    bodyCtrl.close();
  }
}
