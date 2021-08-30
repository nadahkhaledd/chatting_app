import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterationPage extends StatefulWidget {
  static const String routeName = 'registeration';

  @override
  _RegisterationPageState createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  final registerFormKey = GlobalKey<FormState>();

  String username ='';

  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
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

          body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                    key: registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'username',
                          labelStyle: TextStyle(color: Colors.black87),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty)
                            return 'please enter username';
                          return null;
                        },
                        onChanged: (newValue){
                          username = newValue;
                        },

                      ),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'email',
                          labelStyle: TextStyle(color: Colors.black87),
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
                        decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle: TextStyle(color: Colors.black87),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty)
                            return 'please enter password';
                          else if (value.length < 8)
                            return 'password minimum length is 8 characters';
                          return null;
                        },
                        onChanged: (newValue){
                          password = newValue;
                        },
                      ),
                    ],
                  ),
                ),
                isLoading?
                    Center(
                      child: CircularProgressIndicator(),):
                ElevatedButton(onPressed: ()=> createAccount(),
                  child: Text('Create Account'),
                )
              ],
            ),
          ),
        ),
    ],
    );
  }

  bool isLoading = false;

  createAccount()
  {
    if(registerFormKey.currentState?.validate()== true)
      registerUser();
  }

  final authInstance = FirebaseAuth.instance;

  registerUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await authInstance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      showErrorMessage('account successfully created');
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message??'Something went wrong, please try again');
    } catch (e) {
      print(e);
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