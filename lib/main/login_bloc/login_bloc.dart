import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../network/tokens_repository/tokens_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TokensRepository _tokensRepository;

  LoginBloc(this._tokensRepository) : super(LoadingLoginState()) {
    on<InitialLoginEvent>((event, emit) => _onInitialLoginEvent(event, emit));
    on<LogInEvent>((event, emit) => _onLogInEvent(event, emit));
    on<LogOutEvent>((event, emit) => _onLogOutEvent(event, emit));
  }

  _onInitialLoginEvent(InitialLoginEvent event, Emitter<LoginState> emit) async {
    // await _tokensRepository.save("5|QoBqf9Mf4lYLLU2zLW0dIzd57u2s4TyHPv2PF6g7");
    if (_tokensRepository.hasToken()) {
      emit(AuthorizedState());
    } else {
      emit(UnauthorizedState());
    }
  }

  _onLogInEvent(LogInEvent event, Emitter<LoginState> emit) async {
    try {
      await _tokensRepository.save(event.accessToken);
      emit(AuthorizedState());
    } catch (e) {
      emit(ErrorLoginState('errorMessage'));
      emit(UnauthorizedState());
      rethrow;
    }
  }

  _onLogOutEvent(LogOutEvent event, Emitter<LoginState> emit) {
    try {
      _tokensRepository.delete();
      emit(UnauthorizedState());
    } catch (e) {
      emit(ErrorLoginState('errorMessage'));
      rethrow;
    }
  }
}
