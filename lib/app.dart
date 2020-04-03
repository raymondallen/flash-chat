import 'package:flash_chat/data/user_repository.dart';
import 'package:flash_chat/register/register_screen.dart';
import 'package:flash_chat/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'chat/chat_screen.dart';
import 'core/auth/auth_bloc.dart';
import 'login/login_screen.dart';
import 'utilities/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final GlobalKey<NavigatorState> _navigatorKey;

  App(
      {Key key,
      @required UserRepository userRepository,
      @required GlobalKey navigatorKey})
      : assert(userRepository != null && navigatorKey != null),
        _userRepository = userRepository,
        _navigatorKey = navigatorKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        primaryColorDark: kPrimaryColorDark,
        buttonColor: kButtonColor,
        accentColor: kAccentColor,
        primaryColorLight: kPrimaryColorLight,
        dividerColor: kDividerColor,
        textSelectionColor: kTextSelectionColor,
        textTheme: TextTheme(
          body1: TextStyle(color: kTextColor),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/login': (context) => LoginScreen(
              userRepository: _userRepository,
              navigatorKey: _navigatorKey,
            ),
        '/register': (context) => RegisterScreen(
              userRepository: _userRepository,
              navigatorKey: _navigatorKey,
            ),
      },
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return ChatScreen(
              user: state.user,
            );
          }
          if (state is Unauthenticated) {
            return LoginScreen(
              userRepository: _userRepository,
              navigatorKey: _navigatorKey,
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
