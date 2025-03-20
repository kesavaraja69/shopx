import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:shopx/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String name);
  Future<bool> checkLoginStatus();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final f.FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<User> login(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return User(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: userCredential.user!.displayName,
    );
  }

  @override
  Future<User> register(String email, String password, String name) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(name);
    return User(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
    );
  }

  @override
  Future<bool> checkLoginStatus() async {
    return firebaseAuth.currentUser != null;
  }
}
