import 'package:chatting_app/Database/User.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  User? currentUser;

  updateUser(User? user){
    currentUser = user;
    notifyListeners();
  }
}