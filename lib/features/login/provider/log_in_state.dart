class LogInState {
  final String email;
  final String password;
  final bool loading;

  const LogInState({
    this.email = '',
    this.password = '',
    this.loading = false,
  });

  LogInState copyWith({String? email, String? password, bool? loading}) {
    return LogInState(
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
    );
  }
}
