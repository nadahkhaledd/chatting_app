import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/Database/Member.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/componants/componants.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'RoomDetailsScreen.dart';

class JoinRoom extends StatefulWidget {
  static const routeName = "JoinRoomScreen";
 // Room room;
 // JoinRoom(this.room);

  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  late AppProvider provider;
  bool isLoading=false;
  final _formKey = GlobalKey<FormState>();
  late Room room;
  late CollectionReference<Member> joinRef;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as RoomDetails;
     room=args.room!;
    provider = Provider.of<AppProvider>(context);
    joinRef = getMemberCollectionConvertor(room.id);
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
                room.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              //automaticallyImplyLeading: false,
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
              child: Expanded(
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
                          child: Text('Join ' + room.name + '!', style:
                          TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),),
                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/icons/'+room.category+'.png',
                        width: widthResponsive(context: context, width: 0.7),
                        height: heightResponsive(context: context, height: 4),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(room.description, style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.w400, fontSize: 15),),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('Join', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          onPressed: ()
                           {
                            addMembers();
                            Navigator.of(context).pushNamed(RoomDetailsScreen.routeName,arguments: RoomDetailsArgs(room));
                          },
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void addMembers() {
    final newJoin=joinRef.doc();
    final member = Member(
        id: newJoin.id,
        memberId: provider.currentUser!.id,
        username: provider.currentUser!.username,
        );
    newJoin.set(member);
  }

}
class RoomDetails {
  Room room;
  RoomDetails(this.room);
}
