import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/HomePage/HomeScreen.dart';
import 'package:chatting_app/start/RegisterationPage.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../Database/User.dart' as dbUser;

class LoginPage extends StatefulWidget {
 static const String routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final loginFormKey = GlobalKey<FormState>();

 String email = '';
 String password = '';
 bool isLoading = false;
 bool _isObscure = true;
 late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return   Stack(
      children:[

        Container(color: Colors.white),
        Container( decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)
        ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(AppLocalizations.of(context)!.appTitle,
              style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 170, bottom: 8),
                    child: Text(AppLocalizations.of(context)!.welcomeBack, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),),
                  ),
                  Form(
                    key: loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.email,
                            labelStyle: TextStyle(color: Colors.black54),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty)
                              return 'please enter your email';
                            return null;
                          },
                          onChanged: (newValue){
                            email = newValue;
                          },
                        ),

                        TextFormField(
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.password,
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                              onPressed: (){
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            labelStyle: TextStyle(color: Colors.black54),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),

                          validator: (value){
                            if(value == null || value.isEmpty)
                              return 'please enter password';
                            return null;
                          },
                          onChanged: (newValue){
                            password = newValue;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: InkWell(
                      onTap: null,
                      child: Text(AppLocalizations.of(context)!.forgotPass, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),),
                    ),
                  ),

                  isLoading?
                  Center(
                    child: CircularProgressIndicator(),):
                  ElevatedButton(onPressed: ()=> LoginButton(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text(AppLocalizations.of(context)!.login, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                          Expanded(child: Icon(CupertinoIcons.arrow_right)),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: InkWell(
                      onTap: ()=> Navigator.pushReplacementNamed(context, RegisterationPage.routeName),

                      child: Text(AppLocalizations.of(context)!.orCreateAcc, style: TextStyle(color: Colors.black54, fontSize: 14),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  LoginButton()
 {
 if(loginFormKey.currentState?.validate()== true)
      loginUser();
 }

 final database = FirebaseFirestore.instance;

 loginUser() async {
   setState(() {
     isLoading = true;
   });
   try {
     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password
     );
     if(userCredential.user == null)
       showErrorMessage('no user exists with this email and password');
     else{
       getUsersCollection().doc(userCredential.user!.uid).get().then((user){
         provider.updateUser(user.data());
         Navigator.pushReplacementNamed(context, HomeScreen.routeName);
       } );
     }
   } on FirebaseAuthException catch (e) {
     showErrorMessage(e.message??'Something went wrong, please try again');
   }
   setState(() {
     isLoading = false;
   });
 }

 showErrorMessage(String message)
 {
   showDialog(context: context,
       builder: (buildContext) {
         return AlertDialog(
           content: Text(message),
           actions: [
             TextButton(onPressed: (){
               Navigator.pop(context);
             },
                 child: Text('OK'))
           ],

         );
       }
   );
 }
}
