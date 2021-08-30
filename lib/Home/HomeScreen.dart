import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [

          Container(color: Colors.white),
          Container(decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill)
          ),),

          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Chat App',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ]
    );
  }
}
