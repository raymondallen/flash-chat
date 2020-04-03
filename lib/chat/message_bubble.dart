import 'package:flutter/material.dart';
import 'package:message_repository/message_repository.dart';
import 'package:flash_chat/utilities/constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key key,
    @required this.message,
    @required this.userName,
    @required this.nextSender,
  }) : super(key: key);

  final Message message;
  final String userName;
  final String nextSender;

  @override
  Widget build(BuildContext context) {
    return (message.name != userName)
        ?
        // Left bubble
        Container(
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.fromLTRB(
              10.0,
              10.0,
              50.0,
              5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (nextSender != message.sender
                    ? Container(
                        child: Text(
                          message.sender,
                          style: kSenderStyle,
                        ),
                        margin: EdgeInsets.only(
                          right: 10.0,
                        ),
                      )
                    : SizedBox(
                        height: 0.0,
                      )),
                Container(
                  child: Text(
                    message.text,
                    style: kMessageStyle,
                  ),
                ),
              ],
            ),
          )
        :
        // Right bubble
        Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (nextSender != message.sender
                    ? Container(
                        child: Text(
                          message.sender,
                          style: kSenderStyle,
                        ),
                        margin: EdgeInsets.only(
                          right: 10.0,
                        ),
                      )
                    : SizedBox(
                        height: 0.0,
                      )),
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
