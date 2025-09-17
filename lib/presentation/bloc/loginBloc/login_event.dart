part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginClickedEvent extends LoginEvent {
  final String countryCode;
  final String phoneNo;

  LoginClickedEvent({required this.countryCode, required this.phoneNo});
}
