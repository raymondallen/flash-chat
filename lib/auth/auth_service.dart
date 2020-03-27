import 'package:firebase_auth/firebase_auth.dart';
import '../utilities/failure.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

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
        print('ERROR');
        print(e);
        switch (e.code) {
          case 'EMAIL_ALREADY_IN_USE':
            throw Failure('Email already in use.');
            break;
          case 'ERROR_INVALID_EMAIL':
            throw Failure('Email address is not valid.');
            break;
          case 'OPERATION_NOT_ALLOWED':
            throw Failure('Email and password signup is currently disabled.');
            break;
          case 'WEAK_PASSWORD':
            throw Failure('The password is not strong enough.');
            break;
          default:
            throw Failure(e.message);
            break;
        }
      }
    }
  }
}
