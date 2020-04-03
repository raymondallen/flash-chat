import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String text;
  final String sender;
  final String name;
  final Timestamp time;

  const MessageEntity({this.id, this.text, this.sender, this.name, this.time});

  Map<String, Object> toJson() {
    return {
      "id": id,
      "text": text,
      "sender": sender,
      "name": name,
      "time": time,
    };
  }

  @override
  List<Object> get props => [id, text, sender, name, time];

  @override
  String toString() {
    return 'Message { id: $id, text: $text, sender: $sender, name: $name, time: ${time.toString()} }';
  }

  static MessageEntity fromJson(Map<String, Object> json) {
    return MessageEntity(
      id: json["id"] as String,
      text: json["text"] as String,
      sender: json["sender"] as String,
      name: json["name"] as String,
      time: json["time"] as Timestamp,
    );
  }

  static MessageEntity fromSnapshot(DocumentSnapshot snap) {
    return MessageEntity(
      id: snap.documentID,
      text: snap.data['text'],
      sender: snap.data['sender'],
      name: snap.data['name'],
      time: snap.data['time'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "text": text,
      "sender": sender,
      "name": name,
      "time": time,
    };
  }
}
