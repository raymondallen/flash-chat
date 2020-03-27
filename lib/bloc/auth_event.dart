import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInUser extends AuthEvent {
  final String email;
  final String password;

  const SignInUser(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class RegisterUser extends AuthEvent {
  final String email;
  final String password;

  const RegisterUser(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
