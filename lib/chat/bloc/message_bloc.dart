import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:message_repository/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;
  StreamSubscription _messageSubscription;

  MessageBloc({@required MessageRepository messageRepository})
      : assert(messageRepository != null),
        _messageRepository = messageRepository;

  @override
  MessageState get initialState => MessagesLoading();

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is LoadMessages) {
      yield* _mapLoadMessagesToState();
    } else if (event is AddMessage) {
      yield* _mapAddMessageToState(event);
    } else if (event is MessagesUpdated) {
      yield* _mapMessagesUpdateToState(event);
    }
  }

  Stream<MessageState> _mapLoadMessagesToState() async* {
    _messageSubscription?.cancel();
    _messageSubscription = _messageRepository.messages().listen(
          (message) => add(MessagesUpdated(message)),
        );
  }

  Stream<MessageState> _mapAddMessageToState(AddMessage event) async* {
    _messageRepository.addNewMessage(event.message);
  }

  Stream<MessageState> _mapMessagesUpdateToState(MessagesUpdated event) async* {
    yield MessagesLoaded(event.messages);
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
