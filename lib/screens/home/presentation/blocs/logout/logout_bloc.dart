import 'package:clean_architecture_flutter/core/usecases/fetch_token.dart';
import 'package:clean_architecture_flutter/core/utils/constants.dart';
import 'package:clean_architecture_flutter/screens/home/domain/usecases/logout_user.dart';
import 'package:clean_architecture_flutter/screens/home/presentation/blocs/logout/logout_event.dart';
import 'package:clean_architecture_flutter/screens/home/presentation/blocs/logout/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutBloc extends Bloc<dynamic, dynamic> {
  final LogoutUser logoutUser;
  final FetchToken fetchToken;
  static LogoutState get initialState => LoggedInState();

  LogoutBloc({required this.fetchToken, required this.logoutUser})
      : super(initialState) {
    on<UserLogoutEvent>((event, emit) async {
      emit(initialState);
      emit(LoadingState());
      final token = await fetchToken(TokenParams());
      token.fold(
        (failure) => emit(ErrorState(loggingOutErrorConst)),
        (success) async {
          final result = await logoutUser(LogoutParams(token: success.token!));
          result.fold(
            (failure) => emit(ErrorState(loggingOutErrorConst)),
            (success) {
              emit(
                LoggedOutState(),
              );
            },
          );
        },
      );
    });
  }
}
