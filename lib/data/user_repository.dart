import 'model/user.dart';
import 'model/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

class UserRepository {
  final FirebaseAuth _auth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  Future<Option<User>> getUser() async =>
      _auth.currentUser().then((u) => optionOf(u == null
          ? null
          : User(
              id: u.uid,
              name: u.displayName ?? u.email.split('@').first,
              email: u.email,
            )));

  Future<Either<Failure, User>> signInWithCredentials(
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

  Future<Either<Failure, User>> register(String email, String password) async {
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

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }
}
