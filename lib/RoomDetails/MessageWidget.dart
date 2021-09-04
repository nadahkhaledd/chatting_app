import 'package:chatting_app/Database/Messages.dart';
import 'package:chatting_app/tools/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  String? senderId;
  //String? senderName;
  String? content;
  String? senderName;
  int? time;
  MessageWidget(this.content, this.senderId, this.senderName, this.time);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return content == null
        ? Container()
        : (senderId == provider.currentUser?.id
            ? sentMessage(content!, time!)
            : RecievedMessage(content!, senderName!, time!));
  }
}

class sentMessage extends StatelessWidget {
  String content;
  int time;
  sentMessage(this.content, this.time);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(getDateFormatted(time), style: TextStyle(fontSize: 12)),
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
  int time;
  RecievedMessage(this.content, this.senderName, this.time);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          senderName,
          style: TextStyle(color: Color.fromARGB(255, 96, 97, 109)),
        ),
        Row(
          children: [
            Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topLeft: Radius.circular(12))),

                child: Text(content,style: TextStyle(color: Color.fromARGB(255, 96, 97, 109)))
                ),
            Text(getDateFormatted(time), style: TextStyle(fontSize: 12)),
          ],
        )
      ],
    );
  }
}

String getDateFormatted(int time) {
  String answer = getDayFormatted(time) + " " + getTimeFormatted(time);
  return answer;
}

String getTimeFormatted(int time) {
  var output = DateFormat('HH:mm');
  return output.format(DateTime.fromMicrosecondsSinceEpoch(time));
}

String getDayFormatted(int time) {
  DateTime date = DateTime.fromMicrosecondsSinceEpoch(time);
  if (calculateDifference(date) == 0) {
    return "Today";
  } else if (calculateDifference(date) == -1) {
    return "Yesterday";
  } else {
    var output = DateFormat('yMMMMEEEEd');
    return output.format(date);
  }
}

int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
}