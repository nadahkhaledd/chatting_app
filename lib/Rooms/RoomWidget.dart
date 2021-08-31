import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/RoomDetails/RoomDetailsScreen.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  RoomWidget(this.room);
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: ()
        {
            Navigator.of(context).pushNamed(RoomDetailsScreen.routeName,arguments: RoomDetailsArgs(room));
        },
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow:[ BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4,8),
            )]
          ),
        child:  Column(
          children:  [
             ///Adding Image
            Text(room.name),

            ]
          )
        ),
    ),
      );
  }
}

