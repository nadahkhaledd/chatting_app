

import 'package:chatting_app/tools/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Settings extends StatefulWidget {

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
    return Scaffold(


      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '',
                //AppLocalizations.of(context)!.lang,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 250),
              child: DropdownButton(
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
            ),
          ],
        ),
      ),
      );

  }
}
