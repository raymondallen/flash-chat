import 'package:flash_chat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'utilities/routes.dart';
import 'utilities/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth/auth_bloc.dart';
import 'data/user_repository.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        primaryColorDark: kPrimaryColorDark,
        buttonColor: kButtonColor,
        accentColor: kAccentColor,
        primaryColorLight: kPrimaryColorLight,
        dividerColor: kDividerColor,
        textTheme: TextTheme(
          body1: TextStyle(color: kTextColor),
        ),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return ChatScreen(state.user);
          }
          if (state is Unauthenticated) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
