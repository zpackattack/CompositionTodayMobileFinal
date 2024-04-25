import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:compositiontodaymobile1/Screens/competitions2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


import 'package:navbar_router/navbar_router.dart';
import 'FirebaseApi.dart';
import 'Screens/Concerts1.dart';
import 'Screens/Festivals1.dart';
import 'Screens/Jobs1.dart';

import 'Screens/home.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
//import 'NotificationController.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'firebase_options.dart';




Future<void> main() async{
  /*await NotificationController.initializeLocalNotifications(debug: true);
  await NotificationController.initializeRemoteNotifications(debug: true);
  await NotificationController.initializeIsolateReceivePort();
  await NotificationController.getInitialNotificationAction();*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  await FirebaseMessaging.instance.subscribeToTopic('all');


  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
  /*FlutterError.onError = (FlutterErrorDetails details) {
    //print('flutter error hidden from console');
    FlutterError.dumpErrorToConsole(details, forceReport: false);
  };*/
}
/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  //firebase push notification
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}*/

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Tab Navigator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),

        //primarySwatch: Colors.blue,
      ),
      home: MyBottomNavigationBar(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    home(),
    Jobs(),
    Competitions2(),
    Festivals(),
    Concerts(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey, // Change the unselected icon color
        selectedItemColor: Colors.blue,
        selectedLabelStyle: TextStyle(overflow: TextOverflow.visible,),
        unselectedLabelStyle: TextStyle(overflow: TextOverflow.visible,),

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack_outlined,
              size: 23.0,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work,
              size: 23.0,),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events,
              size: 23.0,),
            label: 'Comps'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.festival,
              size: 23.0,),
            label: 'Festivals',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ticket_fill,
              size: 23.0,),
            label: 'Concerts',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}







