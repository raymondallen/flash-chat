import 'package:equatable/equatable.dart';
import '../data/model/user.dart';
import '../data/model/failure.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  const AuthLoading();
  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthState {
  final User user;
  const AuthLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final Failure failure;
  const AuthError(this.failure);
  @override
  List<Object> get props => [failure];
}
