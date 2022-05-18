import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class PushNotificationService{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token; 

  static Future _backgroundHandler(RemoteMessage message)async{
    print('onBackground Handler ${message.messageId }');
  }
  static Future _onMessageHandler(RemoteMessage message)async{
    print('onMessage Handler ${message.messageId }');
  }
  static Future _onMessageOpenApp(RemoteMessage message)async{
    print('onMessageOpenApp Handler ${message.messageId }');
  }

static Future initializeApp()async{
//push notifications
await Firebase.initializeApp();
token = await FirebaseMessaging.instance.getToken();
print('Token: $token');
//handlers
FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
FirebaseMessaging.onMessage.listen(_onMessageHandler);
FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
//local notificacion
}
}