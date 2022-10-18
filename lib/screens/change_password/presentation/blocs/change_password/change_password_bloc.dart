import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/change_password/domain/usecases/change_password.dart';
import 'package:clean_architecture_flutter/screens/change_password/presentation/blocs/change_password/change_password_event.dart';
import 'package:clean_architecture_flutter/screens/change_password/presentation/blocs/change_password/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePassword changePassword;
  ChangePasswordState initialState = InitialState();

  ChangePasswordBloc({required this.changePassword}) : super(InitialState()) {
    on<PasswordChangeEvent>((event, emit) async {
      emit(initialState);
      emit(LoadingState());
      final result = await changePassword(ChangePasswordParams(
          oldPassword: event.oldPassword, newPassword: event.newPassword));
      result.fold((failure) => emit(ErrorState(changePasswordErrorConst)),
          (success) => emit(SuccessfulState()));
    });
  }
}
