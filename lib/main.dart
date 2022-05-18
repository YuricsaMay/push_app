import 'package:flutter/material.dart';
import 'package:push_app/src/pages/home_page.dart';
import 'package:push_app/src/pages/mensaje_page.dart';

import 'src/pages/services/push_notifications_service.dart';

void main()async{

WidgetsFlutterBinding.ensureInitialized();
await PushNotificationService.initializeApp();
  runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Context
    PushNotificationService.messagesStream.listen((message){
      print('MyApp: $message');
  });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push App',
      initialRoute:'home',
      routes:{
        'home': (BuildContext c) => HomePage(),
        'mensaje': (BuildContext c) => MensajePage(),
      },
    );
  }
}