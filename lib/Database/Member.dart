class Member{
  static const String COLLECTION_NAME  = 'members';
  String id;
  String memberId;
  String username;


  Member({required this.id, required this.memberId, required this.username});

  Member.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    memberId: json['memberId']! as String,
    username: json['username']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'memberID': memberId,
      'username': username,
    };
  }

}
