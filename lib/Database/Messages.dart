
class Messages {
  static const String COLLECTION_NAME = 'messages';
  String id;
  String content;
  int time;
  String senderName;
  String senderId;

  Messages(
      {required this.id,
      required this.content,
      required this.time,
      required this.senderName,
      required this.senderId});

  Messages.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          content: json['content']! as String,
          time: json['time']! as int,
          senderName: json['senderName']! as String,
          senderId: json['senderId']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'content': content,
      'time': time,
      'senderNamw': senderName,
      'senderId': senderId
    };
  }
}
