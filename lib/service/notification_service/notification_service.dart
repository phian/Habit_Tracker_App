import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static NotificationService _notificationService;

  static NotificationService get instance {
    if (_notificationService == null) {
      _notificationService = NotificationService();
      return _notificationService;
    } else {
      return _notificationService;
    }
  }

  NotificationService() {
    FirebaseMessaging.instance;
  }

  Future<void> initNotification() async {
    _initAndroidNotificationChannel();
    await _initNotificationPlugin();
    await _initIOSForegroundNotification();
    _onBackgroundMessageHandler();
    _onLocalMessageHandler();
  }

  /// Define a top-level named handler which background/terminated messages will
  /// call.
  ///
  /// To verify things are working, check out the native platform logs.
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print('Handling a background message ${message?.messageId}');
  }

  void _onBackgroundMessageHandler() {
    // Set the background messaging handler early on, as a named top-level function
    // TODO: Tạm comment
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel;

  void _initAndroidNotificationChannel() {
    channel = AndroidNotificationChannel(
      'HabiTracker Channel', // id
      'HabiTrackerChannel Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      enableVibration: true,
      enableLights: true,
    );
  }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> _initNotificationPlugin() async {
    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _initIOSForegroundNotification() async {
    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _onLocalMessageHandler() {
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ),
          );
        }
      },
    );
  }
}
