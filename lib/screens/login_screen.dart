import 'package:flash_chat/components/logo.dart';
import 'package:flash_chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../utilities/routes.dart';
import '../components/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoaded) {
                  Navigator.pushNamed(context, Routes.chat);
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return LinearProgressIndicator();
                  } else if (state is AuthLoaded) {
                    return Text('');
                  } else if (state is AuthError) {
                    return Text(
                      state.failure.message,
                      textAlign: TextAlign.center,
                      style: kErrorStyle,
                    );
                  } else
                    return SizedBox(
                      height: 0,
                    );
                },
              ),
            ),
            RoundedButton(
              label: 'Log In',
              color: Theme.of(context).primaryColor,
              onTap: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(SignInUser(email, password));
              },
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
                Navigator.pushNamed(context, Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
