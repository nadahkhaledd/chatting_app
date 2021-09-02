import 'package:chatting_app/start/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'Settings.dart';

class SideMenu extends Drawer{
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:  Color.fromARGB(255, 53, 152, 219),
          toolbarHeight: 95,
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.appTitle,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 27),
            ),
          ),
        ),
        body: Container(
          //color:  Color(0xFF384A8A),
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: ()
                  { Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                            Icons.settings
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.settings,
                        style: TextStyle(
                          //color: myThemeData.TextColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: ()
                  {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, LoginPage.routeName);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                            Icons.logout
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.logout,
                        style: TextStyle(
                            //color: myThemeData.TextColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}