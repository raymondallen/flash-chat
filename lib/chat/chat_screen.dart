import 'package:flash_chat/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_repository/message_repository.dart';
import 'bloc/message_bloc.dart';
import 'chat_form.dart';

class ChatScreen extends StatelessWidget {
  final User _user;

  ChatScreen({Key key, @required User user})
      : assert(user != null),
        _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MessageBloc>(
            create: (context) => MessageBloc(
              messageRepository: FirestoreMessageRepository(),
            )..add(LoadMessages()),
          ),
        ],
        child: ChatForm(_user),
      ),
    );
  }
}
