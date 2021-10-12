import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService(){
    return _notificationService;
  }

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        //sound: RawResourceAndroidNotificationSound(),
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  Future<void> init() async {
     AndroidInitializationSettings androidInitializationSettings =  const AndroidInitializationSettings("@drawable/ic_stat_access_alarms");
     IOSInitializationSettings iosInitializationSettings = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    final InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );
    
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }



  static Future showNotification({
    required int id,
    required String title,
    required String body,
    required int seconds,
  }) async =>
      flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds == 0 ? 1 : seconds)),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                "main_channel",
                "channel Name",
            channelDescription: "main channel notification",
            importance: Importance.max,
              priority: Priority.max,
              icon: "@drawable/ic_stat_access_alarms"
            ),
            iOS: IOSNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);

  static void cancel(int id) =>flutterLocalNotificationsPlugin.cancel(id);
}