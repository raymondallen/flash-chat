import 'package:flash_chat/core/navigator/navigator_bloc.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/auth/auth_bloc.dart';
import 'core/bloc_delegate.dart';
import 'data/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = AppBlocDelegate();
  final UserRepository _userRepository = UserRepository();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(userRepository: _userRepository)..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => NavigatorBloc(navigatorKey: _navigatorKey),
        ),
      ],
      child: App(
        userRepository: _userRepository,
        navigatorKey: _navigatorKey,
      ),
    ),
  );
}
