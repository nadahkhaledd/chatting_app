//ignore: import_of_legacy_library_into_null_safe
import 'package:chatting_app/RoomDetails/RoomDetailsScreen.dart';
import 'package:chatting_app/Rooms/AddRooms.dart';
import 'package:chatting_app/start/RegisterationPage.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'HomePage/HomeScreen.dart';
import 'start/LoginPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        final provider = Provider.of<AppProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale.fromSubtags(languageCode: provider.currentLocale),
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        RegisterationPage.routeName: (context)=> RegisterationPage(),
        LoginPage.routeName: (context)=> LoginPage(),
    HomeScreen.routeName : (context)=>HomeScreen(),
    AddRooms.routeName: (context)=> AddRooms(),
        RoomDetailsScreen.routeName:(context)=>RoomDetailsScreen()
      },
      initialRoute: LoginPage.routeName,

    );
  }
    );
}
}
