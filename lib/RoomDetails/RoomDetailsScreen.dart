import 'package:chatting_app/Database/DatabaseHelper.dart';
import 'package:chatting_app/Database/Messages.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/RoomDetails/MessageWidget.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatefulWidget {
  static const routeName = "RoomDetailsScreen";

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  late Room room;
  String typedMessage = '';
  late CollectionReference<Messages> messageRef;
  late AppProvider provider;
  late TextEditingController messageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageController = TextEditingController(text: typedMessage);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as RoomDetailsArgs;
    room = args.room;
    messageRef = getMessagesCollectionConvertor(room.id);
    provider = Provider.of<AppProvider>(context);
    final Stream<QuerySnapshot<Messages>> messagesStream =
        messageRef.orderBy('time').snapshots();

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
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Messages>>(
                          stream: messagesStream,
                          builder: (BuildContext buildContext,
                              AsyncSnapshot<QuerySnapshot<Messages>> snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                itemBuilder: (buildContext, index) {
                                  print(snapshot.data?.docs[index].data());
                                  return MessageWidget(
                                      snapshot.data?.docs[index].data());
                                },
                                itemCount: snapshot.data?.size ?? 0,
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          })),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          onChanged: (text) {
                            typedMessage = text;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 4),
                              hintText: "type a message",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12)))),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          sendMessage();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.blue),
                          child: Row(
                            children: [
                              Text(
                                "send",
                                style: TextStyle(color: Colors.white),
                              ),
                              Image.asset('assets/images/send.png')
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    if (typedMessage.isEmpty) return;
    final newMessageObj = messageRef.doc();
    final message = Messages(
        id: newMessageObj.id,
        content: typedMessage,
        time: DateTime.now().microsecondsSinceEpoch,
        senderName: provider.currentUser?.username ?? "",
        senderId: provider.currentUser?.id ?? '');
    newMessageObj.set(message).then((value) {
      setState(() {
        messageController.clear();
      });
    });
  }
}

class RoomDetailsArgs {
  Room room;
  RoomDetailsArgs(this.room);
}
