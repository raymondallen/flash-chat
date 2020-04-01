import 'package:flash_chat/core/navigator/navigator_bloc.dart';
import 'package:flash_chat/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final GlobalKey _navigatorKey;

  LoginScreen(
      {Key key,
      @required UserRepository userRepository,
      @required GlobalKey navigatorKey})
      : assert(userRepository != null && navigatorKey != null),
        _userRepository = userRepository,
        _navigatorKey = navigatorKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(userRepository: _userRepository),
          ),
          BlocProvider<NavigatorBloc>(
            create: (context) => NavigatorBloc(navigatorKey: _navigatorKey),
          )
        ],
        child: LoginForm(),
      ),
    );
  }
}
