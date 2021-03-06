class Room {
  static const COLLECTION_NAME="rooms";
  String id;
  String name;
  String category;
  String description;
  String owner;

  Room(
      {required this.category,
      required this.description,
      required this.id,
      required this.name,
      required this.owner,
     });

  Room.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
    category: json['category']! as String,
    description: json['description']! as String,
    owner: json['owner']! as String

  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'owner': owner

    };
  }


}
