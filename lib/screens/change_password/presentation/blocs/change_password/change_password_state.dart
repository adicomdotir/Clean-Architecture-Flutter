import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends ChangePasswordState {}

class LoadingState extends ChangePasswordState {}

class SuccessfulState extends ChangePasswordState {}

class ErrorState extends ChangePasswordState {
  final String message;

  ErrorState(this.message);
}
