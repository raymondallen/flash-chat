part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class LoadMessages extends MessageEvent {}

class AddMessage extends MessageEvent {
  final Message message;

  const AddMessage(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AddMessage { message: $message }';
}

class MessagesUpdated extends MessageEvent {
  final List<Message> messages;

  const MessagesUpdated(this.messages);

  @override
  List<Object> get props => [messages];
}
