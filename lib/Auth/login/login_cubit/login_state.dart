part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponse loginData;

  LoginSuccess({required this.loginData});
}

final class LoginFailures extends LoginState {
  final Failure error;

  LoginFailures({required this.error});
}
