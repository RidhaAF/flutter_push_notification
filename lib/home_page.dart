import 'package:flutter/material.dart';
import 'package:flutter_push_notification/models/notification_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtrl.stream.listen(_changeData);
    firebaseMessaging.titleCtrl.stream.listen(_changeTitle);
    firebaseMessaging.bodyCtrl.stream.listen(_changeBody);

    super.initState();
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notificationTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              notificationBody,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              notificationData,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              notificationData,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
