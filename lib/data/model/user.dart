import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
  });

  @override
  List<Object> get props => [id, name, email];

  @override
  String toString() {
    return '{ id: ${this.id}, name: ${this.name}, email: ${this.email.toString()} }';
  }
}
