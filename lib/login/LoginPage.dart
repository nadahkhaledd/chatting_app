import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
 static const String routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return  return Stack(
      children:[

        Container(color: Colors.white),
        Container( decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)
        ),),

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Create Account'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
