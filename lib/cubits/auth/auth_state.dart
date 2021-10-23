part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String error;
  const AuthError(this.error);
}

class AuthCompleted extends AuthState {
  final User user;
  const AuthCompleted(this.user);
}
