import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoggedInState extends LogoutState {}

class LoggedOutState extends LogoutState {}

class LoadingState extends LogoutState {}

class ErrorState extends LogoutState {
  final String message;

  ErrorState(this.message);
}
