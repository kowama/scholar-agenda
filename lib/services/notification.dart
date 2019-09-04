import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notification =
      NotificationService._internal(FlutterLocalNotificationsPlugin());

  static FlutterLocalNotificationsPlugin get plugin => _notification._plugin;

  final FlutterLocalNotificationsPlugin _plugin;

  NotificationService._internal(this._plugin) {
    _plugin.initialize(settings(), onSelectNotification: _onSelectNotification);
  }

  InitializationSettings settings() {
    final initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    return initializationSettings;
  }

  void initialize(SelectNotificationCallback selectNotificationCallback) {
    _plugin.initialize(settings(),
        onSelectNotification: selectNotificationCallback);
  }

  Future _onSelectNotification(String payload) {}
}
