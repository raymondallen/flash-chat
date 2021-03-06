import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xffE91E63);
const kPrimaryColorDark = Color(0xffC2185B);
const kButtonColor = Color(0xffE91E63);
const kAccentColor = Color(0xff9E9E9E);
const kPrimaryColorLight = Color(0xffF8BBD0);
const kDividerColor = Color(0xffBDBDBD);
const kTextColor = Color(0xff212121);
const kTextSelectionColor = Color(0xffE91E63);

const kLogoTag = 'logo';

const kSendButtonTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);

const kTextFormFieldDecoration = InputDecoration(
  hintText: '',
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kAccentColor,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
    ),
  ),
  errorStyle: TextStyle(
    color: kPrimaryColor,
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
    ),
  ),
);

// Use for prompts on auth screens
const kPromptStyle = TextStyle(
  color: Colors.white,
);

const kErrorStyle = TextStyle(
  color: Colors.white,
);

const kMessageStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
);

const kSenderStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white70,
);
