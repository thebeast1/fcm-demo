import 'package:fcm_demo/screens/second_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMHandler {
  static getFirebaseToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
    });
  }

  static handleNotification(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("********message recieved");
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("********Message clicked! ${message.data}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const SecondScreen(),
        ),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(message.data["key1"]),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("********Handling a background message");
  }
}
