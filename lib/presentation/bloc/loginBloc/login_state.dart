part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginClickedState extends LoginState {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final LoginModel? user;
  final String? errorMsg;

  LoginClickedState({required this.isLoading, required this.isError, required this.isSuccess, required this.user, required this.errorMsg});
}