//import 'package:chatting_app/Database/Room.dart';
import 'package:chatting_app/Database/Messages.dart';
import 'package:chatting_app/Database/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'Room.dart';
import 'Member.dart';
import 'User.dart';

CollectionReference<dynamic> getUsersCollection()
{
  return FirebaseFirestore.instance.collection(User.COLLECTION_NAME).withConverter<User>(
    fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),);
}

CollectionReference <Room> getRoomsCollectionConvertor()
{
  return FirebaseFirestore.instance.collection(Room.COLLECTION_NAME).withConverter<Room>(
    fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
    toFirestore: (Room, _) => Room.toJson(),);
}
CollectionReference <Messages> getMessagesCollectionConvertor(String roomId)
{
  final roomsCollection = getRoomsCollectionConvertor();
  return roomsCollection.doc(roomId).collection(Messages.COLLECTION_NAME).withConverter<Messages>(
    fromFirestore: (snapshot, _) => Messages.fromJson(snapshot.data()!),
    toFirestore: (message, _) => message.toJson(),);
}

CollectionReference<Member> getMembersCollection()
{
  return FirebaseFirestore.instance.collection(User.COLLECTION_NAME).withConverter<Member>(
    fromFirestore: (snapshot, _) => Member.fromJson(snapshot.data()!),
    toFirestore: (member, _) => member.toJson(),);
}

List<Room> searchRoomsForQuery(List<Room> toBeSearched , String searchValue)
{
  searchValue.toLowerCase();
  final List<Room> matchingRooms= toBeSearched.where((room) {
    final name = room.name.toLowerCase();
    final description = room.description.toLowerCase();
    final category = room.category.toLowerCase();
    return name.contains(searchValue) ||
        description.contains(searchValue) ||
        category.contains(searchValue);
  }).toList();

  return matchingRooms;
}