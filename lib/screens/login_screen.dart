import 'package:flash_chat/components/logo.dart';
import 'package:flash_chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../utilities/routes.dart';
import '../components/text_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: kLogoTag,
              child: Container(
                height: 200.0,
                child: Logo(),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              label: 'Log In',
              color: Theme.of(context).primaryColor,
              onTap: () {},
            ),
            SizedBox(
              height: 48.0,
            ),
            Text(
              'Don\'t have an account yet?',
              textAlign: TextAlign.center,
              style: kPromptStyle,
            ),
            TextButton(
              label: 'Register',
              color: Theme.of(context).primaryColor,
              onTap: () {
                Navigator.pushNamed(context, Routes.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}
