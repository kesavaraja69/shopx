import 'package:fpdart/fpdart.dart';
import 'package:shopx/domain/entities/user.dart';

import '../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(
    String email,
    String password,
    String name,
  );
  Future<Either<Failure, bool>> checkLoginStatus();
  Future<void> logout();
}
