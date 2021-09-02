import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/RoomDetails/RoomDetailsScreen.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          height: 27,
          width: 17,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow:[ BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(4,8),
            )]
          ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage('assets/icons/'+room.category+'.png'),
                width: widthResponsive(context: context, width: 3),
                height: heightResponsive(context: context, height: 10),
                fit: BoxFit.contain,
              ),
            ),

                Text(room.name,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),


            ]
          )
        ),
    ),
      );
  }
}

