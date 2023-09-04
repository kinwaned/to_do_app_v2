import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
class NotifyHelper{
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    tz.initializeTimeZones();
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );


    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/ic_flutter_notification');

    final InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        );

  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  scheduledNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'ToDoo',
        'The theme has been changed 5 seconds ago',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);

  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("No payload");
    }

    if(payload=="Theme Changed"){
    }else{
      Get.to(()=>Container(color: Colors.white,));
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    //   showDialog(
    //     //context: context,
    //     builder: (BuildContext context) => CupertinoAlertDialog(
    //       title: Text(title),
    //       content: Text(body),
    //       actions: [
    //         CupertinoDialogAction(
    //           isDefaultAction: true,
    //           child: Text('Ok'),
    //           onPressed: () async {
    //             Navigator.of(context, rootNavigator: true).pop();
    //             await Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => SecondScreen(payload),
    //               ),
    //             );
    //           },
    //         )
    //       ],
    //     ),
    //   );
    // },
    Get.dialog(const Text('Welcome to Flutter'));
  }
}