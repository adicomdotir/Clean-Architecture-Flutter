import 'package:clean_architecture_flutter/screens/login/domain/entities/login.dart';
import 'package:equatable/equatable.dart';

abstract class UserLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotLoggedState extends UserLoginState {}

class LoadingState extends UserLoginState {}

class ErrorState extends UserLoginState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoggedState extends UserLoginState {
  final Login login;

  LoggedState({required this.login});

  @override
  List<Object?> get props => [login];
}
