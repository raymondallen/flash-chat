import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../components/rounded_button.dart';
import '../utilities/routes.dart';
import '../components/logo.dart';
import '../components/text_button.dart';
import '../auth/auth_change_notifier.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;

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
                email = value;
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
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Consumer<AuthChangeNotifier>(
              builder: (_, notifier, __) {
                if (notifier.state == NotifierState.loading) {
                  return LinearProgressIndicator();
                } else {
                  return notifier.user.fold(
                    (failure) => Text(
                      failure.toString(),
                      textAlign: TextAlign.center,
                      style: kErrorStyle,
                    ),
                    (user) => Text(
                      user.toString(),
                      textAlign: TextAlign.center,
                      style: kErrorStyle,
                    ),
                  );
                }
              },
            ),
            RoundedButton(
              label: 'Register',
              color: Theme.of(context).primaryColor,
              onTap: () async {
                Provider.of<AuthChangeNotifier>(
                  context,
                  listen: false,
                ).registerUser(email, password);
              },
            ),
            SizedBox(
              height: 48.0,
            ),
            Text(
              'Already have an account?',
              textAlign: TextAlign.center,
              style: kPromptStyle,
            ),
            TextButton(
              label: 'Log In',
              color: Theme.of(context).primaryColor,
              onTap: () {
                Navigator.pushNamed(context, Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
