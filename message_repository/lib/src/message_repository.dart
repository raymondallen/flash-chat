import 'dart:async';

import 'package:message_repository/message_repository.dart';

abstract class MessageRepository {
  Future<void> addNewMessage(Message message);

  Stream<List<Message>> messages();
}
