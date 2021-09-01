import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/RoomDetails/RoomDetailsScreen.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;
  //late QueryDocumentSnapshot<Room> room;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            SizedBox(
              height: heightResponsive(context: context, height: 20),

            ),
            Image(
              image: AssetImage('assets/icons/'+room.category+'.png'),
              width: widthResponsive(context: context, width: 3),
              height: heightResponsive(context: context, height: 10),
              fit: BoxFit.contain,
            ),

                Center(
                  child: Text(room.name,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),


            ]
          )
        ),
    ),
      );
  }
}

