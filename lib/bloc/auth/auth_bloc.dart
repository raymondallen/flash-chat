import 'dart:async';
import 'package:equatable/equatable.dart';
import '../../data/model/user.dart';
import '../../data/model/failure.dart';
import 'package:bloc/bloc.dart';
import '../../data/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _repo;

  AuthBloc(UserRepository userRepository)
      : assert(userRepository != null),
        _repo = userRepository;

  @override
  AuthState get initialState => Uninitialised();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    print('EVENT');
    print(event);
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      print('App Started');
      final isSignedIn = await _repo.isSignedIn();
      if (isSignedIn) {
        final userOption = await _repo.getUser();
        yield userOption.fold(
          () => Unauthenticated(),
          (user) => Authenticated(user),
        );
      } else {
        print('UNAUTHENTICATED');
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    final user = await _repo.getUser();
    yield user.fold(
      () => Unauthenticated(),
      (user) => Authenticated(user),
    );
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _repo.signOut();
  }
}
