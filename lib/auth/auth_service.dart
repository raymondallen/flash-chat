import 'package:firebase_auth/firebase_auth.dart';
import '../data/model/failure.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInUser(String email, String password) async {
    if (email == null || email == '') {
      throw Failure('Email cannot be blank.');
    } else if (password == null || password == '') {
      throw Failure('Password cannot be blank.');
    } else {
      try {
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(
                email: email, password: password))
            .user;
        return user;
      } catch (e) {
        throw Failure(e.message);
      }
    }
  }

  Future<FirebaseUser> registerUser(String email, String password) async {
    if (email == null || email == '') {
      throw Failure('Email cannot be blank.');
    } else if (password == null || password == '') {
      throw Failure('Password cannot be blank.');
    } else {
      try {
        FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user;
        return user;
      } catch (e) {
        throw Failure(e.message);
      }
    }
  }
}
