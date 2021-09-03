import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/HomePage/HomeScreen.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RoomDetailsScreen.dart';

class JoinRoom extends StatefulWidget {
  static const routeName = "JoinRoomScreen";
  Room room;
  JoinRoom(this.room);


  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  late AppProvider provider;


  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);

    return Container(
      child: Stack(
        children: [
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
              title: Text(
                widget.room.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                PopupMenuButton(itemBuilder: (context) =>
                [
                  PopupMenuItem(
                      child: InkWell(
                          child: Text('Leave Room'),
                          onTap: () =>
                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.routeName)
                      )
                  )
                ]
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black12, offset: Offset(4, 4))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text('Hello, Welcome to our chat room', style:
                        TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 17),),
                      )
                  ),

                  Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text('Join ' + widget.room.name + '!', style:
                        TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/icons/'+widget.room.category+'.png',
                      width: widthResponsive(context: context, width: 1),
                      height: heightResponsive(context: context, height: 5),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(widget.room.description, style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.w400),),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Join', style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        onPressed: ()
                        {
                          Navigator.of(context).pushNamed(RoomDetailsScreen.routeName,arguments: RoomDetailsArgs(widget.room));
                        },
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}