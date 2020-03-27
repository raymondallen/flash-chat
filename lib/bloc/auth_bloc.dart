import 'dart:async';

import 'package:bloc/bloc.dart';
import '../data/firebase_user_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseUserRepository userRepository;

  AuthBloc(this.userRepository);

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthLoading();
    if (event is SignInUser) {
      final user = await userRepository.signInUser(event.email, event.password);
      print('USER');
      print(user);
      yield user.fold(
        (failure) => AuthError(failure),
        (user) => AuthLoaded(user),
      );
    } else if (event is RegisterUser) {
      final user =
          await userRepository.registerUser(event.email, event.password);
      yield user.fold(
        (failure) => AuthError(failure),
        (user) => AuthLoaded(user),
      );
    }
  }
}
