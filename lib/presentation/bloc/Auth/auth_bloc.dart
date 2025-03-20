import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/domain/usecases/checkloginstatus_usecase.dart';
import 'package:shopx/domain/usecases/login_usecase.dart';
import 'package:shopx/domain/usecases/logout_usecase.dart';
import 'package:shopx/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final CheckLoginstatus checkLoginStatus;
  final Logout logout;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.checkLoginStatus,
    required this.logout,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
    on<LoginOutEvent>(_onLogout);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUser(event.email, event.password);
    emit(
      result.fold(
        (failure) => AuthError(failure.toString()),
        (user) => AuthAuthenticated(),
      ),
    );
  }

  void _onLogout(LoginOutEvent event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await logout();
    await prefs.setBool('isLoggedIn', false);
    emit(AuthuLogout());
  }

  void _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUser(event.email, event.password, event.name);
    emit(
      result.fold(
        (failure) => AuthError(failure.toString()),
        (user) => AuthAuthenticated(),
      ),
    );
  }

  void _onCheckLoginStatus(
    CheckLoginStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await checkLoginStatus();
    emit(
      result.fold(
        (failure) => AuthError(failure.toString()),
        (isLoggedIn) =>
            isLoggedIn ? AuthAuthenticated() : AuthUnauthenticated(),
      ),
    );
  }
}
