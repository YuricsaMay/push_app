import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class PushNotificationService{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token; 
  static StreamController<String> _messageStream=new StreamController.broadcast();
  static Stream<String>get messagesStream=>_messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message)async{
    //print('onBackground Handler ${message.messageId }');
  
  final argumento = message.data['comida'] ?? 'no-data';
    _messageStream.sink.add(argumento);
  //print(message.data);
  //_messageStream.add(message.notification!.title?? 'No title');
  }
  static Future _onMessageHandler(RemoteMessage message)async{
    //print('onMessage Handler ${message.messageId }');
   
   final argumento = message.data['comida'] ?? 'no-data';
    _messageStream.sink.add(argumento);
   //print(message.data);
    //_messageStream.add(message.notification!.title?? 'No title');
  }
  static Future _onMessageOpenApp(RemoteMessage message)async{
   // print('onMessageOpenApp Handler ${message.messageId }');
     
     final argumento = message.data['comida'] ?? 'no-data';
    _messageStream.sink.add(argumento);
    // print(message.data);
     // _messageStream.add(message.notification!.title?? 'No title');
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
static closeStreams(){
  _messageStream.close();
}
}

/*
Para POSTMAN
{
   "notification": {
         "body": "Presiona para entrar",
         "title": "Esta es una notification desde Postman"
       },
       "priority": "high",
       "data": {
         "click_action": "FLUTTER_NOTIFICATION_CLICK",
         "id": "1",
         "status": "done",
         "comida": "Pizza"
       },
       "to": "fwsmDLV0Tu-hNWQG4fLnb9:APA91bG-iBWlNafZdxs403tPoJ3L4UuuXoRcu426OlmiJmA-iSyPlYd8qsWwV3Ttr0jc_tyl6nSz3C_QPzdoiPu2xBVDV-GPJv2zJPVRbGThvQL9rdfU38kgX60r7c_tc6Hllj5sJ3uL"
}
*/