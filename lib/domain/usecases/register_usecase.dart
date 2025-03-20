import 'package:fpdart/fpdart.dart';
import 'package:shopx/core/errors/failures.dart';
import 'package:shopx/domain/entities/user.dart';

import '../repositories/auth_repo.dart';

class RegisterUser {
  final AuthRepository repository;
  RegisterUser(this.repository);

  Future<Either<Failure, User>> call(
    String email,
    String password,
    String name,
  ) {
    return repository.register(email, password, name);
  }
}
