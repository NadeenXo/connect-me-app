import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/auth_service.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      await authService.login(email: email, password: password);

      emit(AuthAuthenticated());
    } catch (error) {
      emit(AuthError(error.toString().replaceFirst('Exception: ', '')));
    }
  }

  // Future<void> signUp({
  //   required String email,
  //   required String password,
  // }) async {
  //   emit(AuthLoading());

  //   try {
  //     await authService.signUp(
  //       email: email,
  //       password: password,
  //     );

  //     emit(AuthAuthenticated());
  //   } catch (error) {
  //     emit(
  //       AuthError(
  //         error.toString().replaceFirst('Exception: ', ''),
  //       ),
  //     );
  //   }
  // }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await authService.signUp(
        fullName: fullName,
        email: email,
        password: password,
      );

      emit(AuthAuthenticated());
    } catch (error) {
      emit(AuthError(error.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await authService.logout();
      emit(AuthUnauthenticated());
    } catch (error) {
      emit(AuthError(error.toString().replaceFirst('Exception: ', '')));
    }
  }

  void checkAuthenticationStatus() {
    if (authService.currentUser != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
