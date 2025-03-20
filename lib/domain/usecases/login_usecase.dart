import 'package:fpdart/fpdart.dart';
import 'package:shopx/core/errors/failures.dart';
import 'package:shopx/domain/entities/user.dart';
import 'package:shopx/domain/repositories/auth_repo.dart';

class LoginUser {
  final AuthRepository repository;
  LoginUser(this.repository);

  Future<Either<Failure, User>> call(String email, String password) {
    return repository.login(email, password);
  }
}
