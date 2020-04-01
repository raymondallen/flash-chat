import 'package:flash_chat/core/navigator/navigator_bloc.dart';
import 'package:flash_chat/data/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/register_bloc.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final GlobalKey<NavigatorState> _navigatorKey;

  RegisterScreen(
      {Key key,
      @required UserRepository userRepository,
      @required GlobalKey navigatorKey})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _navigatorKey = navigatorKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(userRepository: _userRepository),
          ),
          BlocProvider<NavigatorBloc>(
            create: (context) => NavigatorBloc(navigatorKey: _navigatorKey),
          )
        ],
        child: RegisterForm(),
      ),
    );
  }
}
