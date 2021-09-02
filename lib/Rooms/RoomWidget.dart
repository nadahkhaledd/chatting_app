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
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 37,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow:[ BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(4,8),
            )]
          ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Image.asset("assets/icons/Movies.png"),
               /*Image.asset(room.category=='Movies'?"assets/icons/Movies.png"
                   : room.category=='Sports'? "assets/icons/sports.png": "assets/icons/music.png"),*/
             ),
            Text(room.name, style: TextStyle(fontWeight: FontWeight.w500),),

            ]
          )
        ),
    ),
      );
  }
}

