import 'package:fpdart/fpdart.dart';
import 'package:shopx/core/errors/failures.dart';
import 'package:shopx/domain/repositories/auth_repo.dart';

class CheckLoginstatus {
  final AuthRepository repository;
  CheckLoginstatus(this.repository);

  Future<Either<Failure, bool>> call() {
    return repository.checkLoginStatus();
  }
}
