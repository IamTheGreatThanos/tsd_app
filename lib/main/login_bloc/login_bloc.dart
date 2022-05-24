import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy_arrival/domain/usecases/auth_check.dart';
import 'package:pharmacy_arrival/widgets/dynamic_link_layer/bloc/dynamic_link_layer_bloc.dart';

import '../../network/tokens_repository/tokens_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthCheck _authCheck;

  LoginBloc(this._authCheck) : super(LoadingLoginState()) {
    on<InitialLoginEvent>((event, emit) => _onInitialLoginEvent(emit));
    on<LogInEvent>((event, emit) => _onLogInEvent(event, emit));
    on<LogOutEvent>((event, emit) => _onLogOutEvent(event, emit));
  }

  // _onInitialLoginEvent(InitialLoginEvent event, Emitter<LoginState> emit) async {
  //   // await _tokensRepository.save("5|QoBqf9Mf4lYLLU2zLW0dIzd57u2s4TyHPv2PF6g7");
  //   if (_tokensRepository.call()) {
  //     emit(AuthorizedState());
  //   } else {
  //     emit(UnauthorizedState());
  //   }
  // }

  _onLogInEvent(LogInEvent event, Emitter<LoginState> emit) async {
    try {
      emit(AuthorizedState());
    } catch (e) {
      emit(ErrorLoginState('errorMessage'));
      emit(UnauthorizedState());
      rethrow;
    }
  }

  _onLogOutEvent(LogOutEvent event, Emitter<LoginState> emit) {
    try {
      emit(UnauthorizedState());
    } catch (e) {
      emit(ErrorLoginState('errorMessage'));
      rethrow;
    }
  }

  
  Future<void> _onInitialLoginEvent(
    Emitter<LoginState> emit,
  ) async {
    final result = await _authCheck.call();

    result.fold(
      (l) => emit(UnauthorizedState()),
      (r) async {
        emit(AuthorizedState());
      },
    );
  }

}
