import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/data/repositories/accept_containers_repository.dart';

part 'accept_cont_launch_state.dart';
part 'accept_cont_launch_cubit.freezed.dart';

class AcceptContLaunchCubit extends Cubit<AcceptContLaunchState> {
  final AcceptContainersRepository acceptContainersRepository;

  AcceptContLaunchCubit(this.acceptContainersRepository)
      : super(const AcceptContLaunchState.initialState());

  Future<void> checkAcceptCont() async {
    emit(const AcceptContLaunchState.loadingState());
    final result =
        await acceptContainersRepository.getContainerNumberFromCache();
    result.fold((l) {
      emit(const AcceptContLaunchState.passiveState());
    }, (r) {
      emit(const AcceptContLaunchState.activeState());
    });
  }

  void chageToPassiveState() {
    emit(const AcceptContLaunchState.passiveState());
  }

  void chageToActiveState() {
    emit(const AcceptContLaunchState.activeState());
  }
}
