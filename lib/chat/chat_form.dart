import 'package:flash_chat/chat/bloc/message_bloc.dart';
import 'package:flash_chat/core/auth/auth_bloc.dart';
import 'package:flash_chat/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:message_repository/message_repository.dart';
import '../utilities/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatForm extends StatefulWidget {
  final user;

  ChatForm(this.user);

  @override
  _ChatFormState createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  AuthBloc _authBloc;
  MessageBloc _messageBloc;
  User _user;
  List<Message> _messages = [];

  final TextEditingController _textController = TextEditingController();
  bool get isPopulated => _textController.text.isNotEmpty;

  FocusNode _focusNode;

  bool isSendEnabled() {
    return isPopulated;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _user = this.widget.user;
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _messageBloc = BlocProvider.of<MessageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is MessagesLoaded) {
          _messages = state.messages;
        }
      },
      child: BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: null,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _authBloc.add(LoggedOut());
                  }),
            ],
            title: Text('Flash Chat'),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final message = _messages[index];
                      return Text(
                        message.text,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _textController,
                          decoration: kMessageTextFieldDecoration,
                          focusNode: _focusNode,
                          keyboardType: TextInputType.text,
                          autovalidate: true,
                          autocorrect: false,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          _onSubmit(
                              _textController.text, _user.email, _user.name);
                          _focusNode.requestFocus();
                        },
                        child: Text(
                          'Send',
                          style: kSendButtonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _onSubmit(String message, String sender, String name) {
    if (isSendEnabled()) {
      _messageBloc.add(AddMessage(Message(message, sender, name)));
      _textController.clear();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
