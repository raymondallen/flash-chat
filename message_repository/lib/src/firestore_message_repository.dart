import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_repository/message_repository.dart';
import 'entities/entities.dart';

class FirestoreMessageRepository implements MessageRepository {
  final messageCollection = Firestore.instance.collection('messages');

  @override
  Future<void> addNewMessage(Message message) {
    return messageCollection.add(message.toEntity().toDocument());
  }

  @override
  Stream<List<Message>> messages() {
    return messageCollection
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) => Message.fromEntity(MessageEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
