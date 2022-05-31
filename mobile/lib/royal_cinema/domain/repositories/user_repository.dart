import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>>? getUser();
  // Future<Either<Failure, User>> getUser(String id, String fullName, String phoneNumber, String passwordHash, String booked, double balance);
}