part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessagesLoading extends MessageState {}

class MessagesLoaded extends MessageState {
  final List<Message> messages;

  const MessagesLoaded([this.messages = const []]);

  @override
  List<Object> get props => [messages];

  @override
  String toString() => 'MessagesLoaded { messages: $messages }';
}

class MessagesNotLoaded extends MessageState {}
