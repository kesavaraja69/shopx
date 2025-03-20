import 'package:firebase_auth/firebase_auth.dart' as fsauth;
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/core/errors/failures.dart';
import 'package:shopx/domain/entities/user.dart';
import '../../domain/repositories/auth_repo.dart';
import '../src/auth_firebase_datasource.dart';

import 'dart:developer' as devtools show log;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl(this.remoteDataSource, this.sharedPreferences);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      devtools.log("user- ${user.name.toString()} logged in");
      await sharedPreferences.setBool('isLoggedIn', true);
      await sharedPreferences.setString('username', user.name.toString());
      return Right(user);
    } on fsauth.FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'Not user found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user';
      }

      devtools.log(message);

      return Left(AuthFailure(message));
    }
  }

  @override
  Future<Either<Failure, User>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final user = await remoteDataSource.register(email, password, name);
      devtools.log("user- ${user.name.toString()} Register success");

      await sharedPreferences.setBool('isLoggedIn', true);
      await sharedPreferences.setString('username', user.name.toString());
      return Right(user);
    } on fsauth.FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }

      return Left(AuthFailure(message));
    }
  }

  @override
  Future<Either<Failure, bool>> checkLoginStatus() async {
    try {
      final isLoggedIn = await remoteDataSource.checkLoginStatus();
      return Right(isLoggedIn);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    try {
      remoteDataSource.logout();
    } catch (e) {
      AuthFailure(e.toString());
    }
  }
}
