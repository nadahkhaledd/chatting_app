import 'package:chatting_app/componants/componants.dart';
import 'package:chatting_app/registeration/RegisterationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return   Stack(
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
            title: Text('Login', style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 65, bottom: 8),
                  child: Text('Welcome back!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),),
                ),
                Form(
                  key: loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                          labelText: 'Password',
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
                    child: Text('Forgot password?', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),),
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
                        Expanded(flex: 3, child: Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                        Expanded(child: Icon(CupertinoIcons.arrow_right)),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: ()=> Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterationPage())),

                    child: Text('or Create an account', style: TextStyle(color: Colors.black54, fontSize: 14),),
                  ),
                )
              ],
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

 loginUser() async {
   setState(() {
     isLoading = true;
   });
   try {
     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password
     );
     showErrorMessage('data is correct');
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
