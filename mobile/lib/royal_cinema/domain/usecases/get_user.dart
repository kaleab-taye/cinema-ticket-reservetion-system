import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class getUser {
  final UserRepository repository;

  getUser(this.repository);

  Future<Either<Failure, User>?> execute() async {
    return await repository.getUser();
  }
}