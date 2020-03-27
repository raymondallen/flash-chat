import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import '../data/model/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum NotifierState { initial, loading, loaded }

class AuthChangeNotifier extends ChangeNotifier {
  final _authService = AuthService();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  Either<Failure, FirebaseUser> _user;
  Either<Failure, FirebaseUser> get user => _user;
  void _setUser(Either<Failure, FirebaseUser> user) {
    _user = user;
    notifyListeners();
  }

  void registerUser(String email, String password) async {
    _setState(NotifierState.loading);
    await Task(() => _authService.registerUser(email, password))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((value) => _setUser(value));
    _setState(NotifierState.loaded);
  }

  void signInUser(String email, String password) async {
    _setState(NotifierState.loading);
    await Task(() => _authService.signInUser(email, password))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((value) => _setUser(value));
    _setState(NotifierState.loaded);
  }
}

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return this.map(
      (either) => either.leftMap((obj) {
        try {
          return obj as Failure;
        } catch (e) {
          throw obj;
        }
      }),
    );
  }
}
