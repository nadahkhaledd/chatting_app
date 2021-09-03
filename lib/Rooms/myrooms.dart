import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/Rooms/RoomWidget.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class myroom extends StatelessWidget {
  //late CollectionReference<Room> roomCollectionRef;
  CollectionReference<Room> roomCollectionRef = getRoomsCollectionConvertor();
   List<Room> ownRooms = [];
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
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
              for(Room room in roomList)
                {
                  if(room.owner == provider.currentUser!.username)
                    {
                      ownRooms.add(room);
                    }
                  //print(roomList.length);
                  /*if(room.owner == provider.currentUser!.username){
                    if(ownRooms.length> 0)
                    {
                      if(!ownRooms.contains(room))
                      {
                        print("doesn't exist");
                        ownRooms.insert(roomList.indexOf(room), room);
                      }
                    }
                    else if (ownRooms.length == 0) {
                      print(roomList.indexOf(room));
                      ownRooms.insert(0, room);
                    }
                  }*/

                }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext, index) {
                  return RoomWidget(ownRooms[index]);
                },
                itemCount: ownRooms.length,
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
