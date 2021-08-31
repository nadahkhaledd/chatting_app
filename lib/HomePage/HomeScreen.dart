import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/Rooms/AddRooms.dart';
import 'package:chatting_app/Rooms/RoomWidget.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   static const String routeName = 'HomeScreen';
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';
  late CollectionReference <Room> roomCollectionRef;
  HomeScreen() {
      roomCollectionRef= getRoomsCollectionConvertor();
  }
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
            title: Text('Chat App', style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, AddRooms());
            },
            child: Icon(Icons.add),

          ),
          body: Container(

            margin: EdgeInsets.only(bottom:12,left: 12,right: 12,top: 64 ),
            child: FutureBuilder<QuerySnapshot<Room>> (
              future: roomCollectionRef.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Room>> snapshot){
                if(snapshot.hasError)
                  return Text("has error");
                else if(snapshot.connectionState==ConnectionState.done){
                  final List<Room> roomList=snapshot.data?.docs.map((singleDoc) => singleDoc.data()).toList()??[];
                  return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                   mainAxisSpacing: 4,
                  ), itemBuilder: (BuildContext ,index){
                    return RoomWidget(roomList[index]);
    },
    itemCount:roomList.length,
    );

    }
                else
                  return Center(child: CircularProgressIndicator(),);
    }
              ),
            ),
          ),

      ],
    );
  }
}
