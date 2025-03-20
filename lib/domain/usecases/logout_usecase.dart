import 'package:fpdart/fpdart.dart';
import 'package:shopx/core/errors/failures.dart';
import 'package:shopx/domain/repositories/auth_repo.dart';

class Logout {
  final AuthRepository repository;
  Logout(this.repository);

  Future<Either<Failure, bool>> call() {
    return repository.checkLoginStatus();
  }
}
