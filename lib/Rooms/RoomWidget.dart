import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/Database/Member.dart';
import 'package:chatting_app/Database/Messages.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/RoomDetails/JoinRoom.dart';
import 'package:chatting_app/RoomDetails/RoomDetailsScreen.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class RoomWidget extends StatefulWidget {
  Room room;
  RoomWidget(this.room);

  @override
  _RoomWidgetState createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  late CollectionReference<Member> memberRef;
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);

    memberRef = getMemberCollectionConvertor(widget.room.id);
    final Stream<QuerySnapshot<Member>> memberStream = memberRef.snapshots();
    int members =0;
    return InkWell(
      onTap: () {
        if(memberStream.contains(provider.currentUser!.id))
          {
            Navigator.of(context).pushNamed(RoomDetailsScreen.routeName, arguments: RoomDetailsArgs(widget.room));
          }
        else
          {
            Navigator.of(context).pushNamed(JoinRoom.routeName,arguments:RoomDetails(widget.room));

          }
        // if (membersList.contains(provider.currentUser!.id)) {
        //   Navigator.of(context).pushNamed(RoomDetailsScreen.routeName,
        //       arguments: RoomDetailsArgs(widget.room));
        // } else {
        //   var route = new MaterialPageRoute(
        //     builder: (BuildContext context) => JoinRoom(widget.room),
        //   );
        //   Navigator.of(context).push(route);
        // }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            height: 27,
            width: 17,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(4, 8),
                  )
                ]),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: AssetImage(
                          'assets/icons/' + widget.room.category + '.png'),
                      width: widthResponsive(context: context, width: 3),
                      height: heightResponsive(context: context, height: 10),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    widget.room.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  ///here///
                  /*Expanded(
                    child: StreamBuilder<QuerySnapshot<Member>>(
                        stream: memberStream,
                        builder: (BuildContext buildContext,
                            AsyncSnapshot<QuerySnapshot<Member>> snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else if (snapshot.hasData) {
                            var membersL=snapshot.data?.docs.length;
                            membersList = [];
                            for(int i=0; i< membersL!; i++)
                            {
                              membersList.add(snapshot.data?.docs[i].get('memberId').toString());
                            }
                            //members = membersL;

                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),*/
                  Text(
                    '$members' + ' members',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ])),
      ),
    );
  }
}
