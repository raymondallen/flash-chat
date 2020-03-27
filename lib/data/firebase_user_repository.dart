import 'user_repository.dart';
import 'model/user.dart';
import 'model/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _auth;

  FirebaseUserRepository(this._auth);

  @override
  Future<Either<Failure, User>> signInUser(
      String email, String password) async {
    if (email == null || email == '') {
      throw ('Email cannot be blank.');
    } else if (password == null || password == '') {
      throw ('Password cannot be blank.');
    } else {
      try {
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(
                email: email, password: password))
            .user;
        return right(User(
          id: user.uid,
          name: user.displayName ?? user.email.split('@').first,
          email: user.email,
        ));
      } on PlatformException catch (e) {
        return left(Failure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(
      String email, String password) async {
    if (email == null || email == '') {
      throw ('Email cannot be blank.');
    } else if (password == null || password == '') {
      throw ('Password cannot be blank.');
    } else {
      try {
        FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user;
        return right(User(
          id: user.uid,
          name: user.displayName ?? user.email.split('@').first,
          email: user.email,
        ));
      } on PlatformException catch (e) {
        return left(Failure(e.message));
      }
    }
  }
}
