import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLogoutEvent extends LogoutEvent {}
