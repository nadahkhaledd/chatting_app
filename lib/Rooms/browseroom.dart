import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/Rooms/RoomWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BrowseRoom extends StatelessWidget {
  //late CollectionReference<Room> roomCollectionRef;

    CollectionReference<Room> roomCollectionRef = getRoomsCollectionConvertor();

  @override

  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Room>> roomsStream = roomCollectionRef.snapshots();

    return Container(
      child:
      StreamBuilder<QuerySnapshot<Room>>(
          stream: roomsStream,
          builder: (BuildContext buildContext,AsyncSnapshot<QuerySnapshot<Room>>snapshot){
            if( snapshot.hasError) return Text("has error");
            else if(snapshot.hasData)
            {
              final List<Room> roomList = snapshot.data?.docs
                  .map((singleDoc) => singleDoc.data())
                  .toList() ?? [];
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext, index) {
                  return RoomWidget(roomList[index]);
                },
                itemCount: snapshot.data?.size??0,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );

          }
      ) ,
    );
  }
}
