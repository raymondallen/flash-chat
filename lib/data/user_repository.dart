import 'model/user.dart';
import 'model/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signInUser(String email, String password);
  Future<Either<Failure, User>> registerUser(String email, String password);
}
