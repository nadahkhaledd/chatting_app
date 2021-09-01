import 'package:chatting_app/Database/Messages.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Messages? message;
  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return message == null
        ? Container()
        : (message?.senderId == provider.currentUser?.id
            ? sentMessage(message!)
            : RecievedMessage(message!));
  }
}

class sentMessage extends StatelessWidget {
  Messages message;

  sentMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(message.getDateFormatted()),
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
            child: Text(message.content, style: TextStyle(color: Colors.white)))
      ],
    );
  }
}

class RecievedMessage extends StatelessWidget {
  Messages message;
  RecievedMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message.senderName),
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
                child: Text(message.content,
                    style: TextStyle(color: Colors.blue))),
            Text(message.getDateFormatted()),
          ],
        )
      ],
    );
  }
}
