import 'package:chatting_app/Database/User.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  User? currentUser;
  String currentLocale = "en";
  Color primaryColor = Color.fromARGB(255, 53, 152, 219);

  void changeLanguage(String lang) {
    if (currentLocale == lang) return;
    currentLocale = lang;
    notifyListeners();
  }
  updateUser(User? user){
    currentUser = user;
    notifyListeners();
  }
}