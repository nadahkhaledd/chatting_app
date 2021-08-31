//ignore: import_of_legacy_library_into_null_safe
import 'package:chatting_app/Rooms/AddRooms.dart';
import 'package:chatting_app/start/RegisterationPage.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage/HomeScreen.dart';
import 'start/LoginPage.dart';

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
    return ChangeNotifierProvider(
        create: (context)=> AppProvider(),
      builder: (context, widget){

    return MaterialApp(
      routes: {
        RegisterationPage.routeName: (context)=> RegisterationPage(),
        LoginPage.routeName: (context)=> LoginPage(),
    HomeScreen.routeName : (context)=>HomeScreen(),
    AddRooms.routeName: (context)=> AddRooms(),
      },
      initialRoute: LoginPage.routeName,

    );
  }
    );
}
}
