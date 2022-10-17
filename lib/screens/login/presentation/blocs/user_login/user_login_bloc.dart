import 'package:clean_architecture_flutter/core/usecases/fetch_token.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/login/domain/usecases/login_user.dart';
import 'package:clean_architecture_flutter/screens/login/presentation/blocs/user_login/user_login_event.dart';
import 'package:clean_architecture_flutter/screens/login/presentation/blocs/user_login/user_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final LoginUser loginUser;
  final FetchToken fetchToken;
  final UserLoginState initialState = NotLoggedState();

  UserLoginBloc({required this.loginUser, required this.fetchToken})
      : super(NotLoggedState()) {
    on<LoginEvent>((event, emit) async {
      emit(initialState);
      emit(LoadingState());
      final result = await loginUser(
          LoginParams(email: event.email, password: event.password));
      result.fold((failure) => emit(ErrorState(message: loggingErrorConst)),
          (success) => emit(LoggedState(login: success)));
    });

    on<CheckLoginStatusEvent>((event, emit) async {
      emit(initialState);
      emit(LoadingState());
      final result = await fetchToken(TokenParams());
      result.fold((failure) => emit(NotLoggedState()),
          (success) => emit(LoggedState(login: success)));
    });
  }
}
