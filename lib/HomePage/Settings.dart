

import 'package:chatting_app/HomePage/HomeScreen.dart';
import 'package:chatting_app/HomePage/SideMenu.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Settings extends StatefulWidget {
  static const String routeName = 'Settings';
  String language = 'English';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> languages = ['English', 'العربية'];
  String language = 'English';
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider =Provider.of<AppProvider>(context, listen: false);
    language = provider.currentLocale== 'en'? 'English' : 'العربية';
    return Stack(

      children:[
        Container(color: Colors.white),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill)),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName), icon: Icon(CupertinoIcons.chevron_forward))
          ],
          backgroundColor: Colors.transparent,
          title: Text('Settings'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),

        drawer: SideMenu(),


        body: Padding(
          padding: const EdgeInsets.only(
            left: 8, right: 8, top: 135
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              DropdownButton(
                style: TextStyle(color: Colors.black),

                focusColor:  provider.primaryColor,
                dropdownColor: provider.primaryColor,
                iconSize: 30.0,
                iconDisabledColor: provider.primaryColor,
                iconEnabledColor: provider.primaryColor,
                isExpanded: true,
                value: language,
                items: languages.map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(
                      language,
                      style: TextStyle(color: Colors.black87),
                    ),
                    onTap: null,
                  );
                }).toList(),
                onChanged: (value) {
                  //Navigator.pop(context);
                  setState(() {
                    language = value.toString();
                    if (language == "English")
                      provider.changeLanguage("en");
                    else
                      provider.changeLanguage("ar");
                  });
                },
              ),
            ],
          ),
        ),
        ),
    ],
    );

  }
}
