import 'package:chatting_app/Database/Messages.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  String? senderId;
  //String? senderName;
  String? content;
  String? senderName;
  int? time;
  MessageWidget(this.content,this.senderId,this.senderName,this.time);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return content == null
        ? Container()
        : (senderId == provider.currentUser?.id
            ? sentMessage(content!)
            : RecievedMessage(content!,senderName!));
  }
}

class sentMessage extends StatelessWidget {
  String content;

  sentMessage(this.content);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(content),
        Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Text(content, style: TextStyle(color: Colors.white)))
      ],
    );
  }
}

class RecievedMessage extends StatelessWidget {
  String content;
  String senderName;
  RecievedMessage(this.content,this.senderName);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(senderName),
        Row(
          children: [
            Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Text(content,
                    style: TextStyle(color: Colors.blue))),
            Text(content),
          ],
        )
      ],
    );
  }
}
