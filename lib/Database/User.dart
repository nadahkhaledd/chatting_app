class User{
  static const String COLLECTION_NAME  = 'users';
  String id;
  String username;
  String email;

   String get getUsername => username;

  User({required this.id, required this.username, required this.email});

  User.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    username: json['username']! as String,
    email: json['email']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

}