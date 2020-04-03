import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Message {
  final String id;
  final String text;
  final String sender;
  final String name;
  final DateTime time;

  Message(this.text, this.sender, this.name, {String id, DateTime time})
      : this.time = time ?? DateTime.now(),
        this.id = id;

  Message copyWith(
      {String id, String text, String sender, String name, DateTime time}) {
    return Message(
      text ?? this.text,
      sender ?? this.sender,
      name ?? this.name,
      id: id ?? this.id,
      time: time ?? this.time,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      text.hashCode ^
      sender.hashCode ^
      name.hashCode ^
      time.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          sender == other.sender &&
          name == other.name &&
          time == other.time;

  @override
  String toString() {
    return 'Message { id: $id, text: $text, sender: $sender, name: $name, time: ${time.toString()} }';
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      text: text,
      sender: sender,
      name: name,
      time: Timestamp.fromDate(time),
    );
  }

  static Message fromEntity(MessageEntity entity) {
    return Message(
      entity.text,
      entity.sender,
      entity.name,
      id: entity.id,
      time: DateTime.parse(entity.time.toDate().toString()),
    );
  }
}
