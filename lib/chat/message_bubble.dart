import 'package:flutter/material.dart';
import 'package:message_repository/message_repository.dart';
import 'package:flash_chat/utilities/constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key key,
    @required this.message,
    @required this.email,
    @required this.nextSender,
  }) : super(key: key);

  final Message message;
  final String email;
  final String nextSender;

  @override
  Widget build(BuildContext context) {
    return (message.sender != email)
        ?
        // Left bubble
        (message.sender == nextSender
            ? LeftBubble(message)
            : LeftBubbleWithSender(message))
        :
        // Right bubble
        (message.sender == nextSender
            ? RightBubble(message)
            : RightBubbleWithSender(message));
  }
}

class RightBubble extends StatelessWidget {
  final Message message;
  const RightBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      decoration: BoxDecoration(
        color: kAccentColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.fromLTRB(
        50.0,
        5.0,
        10.0,
        0.0,
      ),
      child: Container(
        child: Text(
          message.text,
          style: kMessageStyle,
        ),
      ),
    );
  }
}

class RightBubbleWithSender extends StatelessWidget {
  final Message message;
  const RightBubbleWithSender(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      decoration: BoxDecoration(
        color: kAccentColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.fromLTRB(
        50.0,
        10.0,
        10.0,
        0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              message.sender,
              style: kSenderStyle,
            ),
            margin: EdgeInsets.only(
              right: 10.0,
            ),
          ),
          Container(
            child: Text(
              message.text,
              style: kMessageStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class LeftBubble extends StatelessWidget {
  final Message message;
  const LeftBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.fromLTRB(
        10.0,
        5.0,
        50.0,
        0.0,
      ),
      child: Container(
        child: Text(
          message.text,
          style: kMessageStyle,
        ),
      ),
    );
  }
}

class LeftBubbleWithSender extends StatelessWidget {
  final Message message;
  const LeftBubbleWithSender(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.fromLTRB(
        10.0,
        10.0,
        50.0,
        0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              message.sender,
              style: kSenderStyle,
            ),
            margin: EdgeInsets.only(
              right: 10.0,
            ),
          ),
          Container(
            child: Text(
              message.text,
              style: kMessageStyle,
            ),
          ),
        ],
      ),
    );
  }
}
