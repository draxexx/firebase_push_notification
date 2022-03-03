import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'local_notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String firebaseMessage = "Waiting for firebase message";

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getToken().then((token) {
      print("This is Token: $token");
    });

    LocalNotificationService.initilize();

    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          firebaseMessage =
              "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
        });
      }
    });

    // Foregrand State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        firebaseMessage =
            "${event.notification!.title} ${event.notification!.body} I am coming from foreground";
      });
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        firebaseMessage =
            "${event.notification!.title} ${event.notification!.body} I am coming from background";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(firebaseMessage),
      ),
    );
  }
}
