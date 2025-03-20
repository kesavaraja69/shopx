import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/core/utils/shared_prefs.dart';
import 'package:shopx/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String name);
  Future<bool> checkLoginStatus();
  Future<void> logout();
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

  @override
  Future<void> logout() async {
    await SharedPrefs.setOnboardingShown();
    return await firebaseAuth.signOut();
  }
}
