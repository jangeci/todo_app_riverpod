import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/login/provider/log_in_state.dart';

class LogInNotifier extends StateNotifier<LogInState> {
  LogInNotifier() : super(const LogInState());

  void onEmailChange(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChange(String pass) {
    state = state.copyWith(password: pass);
  }

  void onLoadingChange(bool loading) {
    state = state.copyWith(loading: loading);
  }
}

final logInNotifierProvider = StateNotifierProvider<LogInNotifier, LogInState>((ref) => LogInNotifier());
