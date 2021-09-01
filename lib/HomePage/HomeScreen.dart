import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/Rooms/AddRooms.dart';
import 'package:chatting_app/Rooms/RoomWidget.dart';
import 'package:chatting_app/Rooms/browseroom.dart';
import 'package:chatting_app/Rooms/myrooms.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Tab> screensTabs = [
    Tab(text: "MyRooms"),
    Tab(text: "Browse"),
  ];
  List<Widget> screens=[
    MyRooms(),
    BrowseRoom(),
  ];
  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
  return DefaultTabController(
    length: screensTabs.length,
    child: Builder(builder: (BuildContext context) {
      final TabController tabController = DefaultTabController.of(context)!;
      tabController.addListener(() {
        if (!tabController.indexIsChanging) {
        }
      });
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

              bottom: TabBar(
                tabs:screensTabs,
              ),
              title: Text(
                'Chat App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 40,),)
              ],

            ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        navigateTo(context, AddRooms());
      },
      child: Icon(Icons.add),
      ),
      body: TabBarView(
      children: screens,
      ),
      )
        ]

      );

    }),
  );
  }
}
