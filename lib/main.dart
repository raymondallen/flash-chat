import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth/auth_bloc.dart';
import 'data/user_repository.dart';
import 'bloc/bloc_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = AppBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(userRepository)..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}
