import 'package:equatable/equatable.dart';

abstract class UserLoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends UserLoginEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class CheckLoginStatusEvent extends UserLoginEvent {}

class SkipLoginEvent extends UserLoginEvent {}
