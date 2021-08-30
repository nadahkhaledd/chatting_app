// ignore: import_of_legacy_library_into_null_safe
import 'package:chatting_app/registeration/RegisterationPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login/LoginPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterationPage.routeName: (context)=> RegisterationPage(),
        LoginPage.routeName: (context)=> LoginPage(),
      },
      initialRoute: RegisterationPage.routeName,

    );
  }
}

