import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PasswordChangeEvent extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  PasswordChangeEvent({required this.oldPassword, required this.newPassword});
}
