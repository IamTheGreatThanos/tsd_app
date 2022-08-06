import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/repositories/accept_containers_repository.dart';

@freezed
part 'accept_cont_qr_state.dart';
part 'accept_cont_qr_cubit.freezed.dart';

class AcceptContQrCubit extends Cubit<AcceptContQrState> {
  final AcceptContainersRepository _acceptContainersRepository;
  AcceptContQrCubit(this._acceptContainersRepository)
      : super(const AcceptContQrState.initialState());

  Future<void> getContainerByAng({required String number}) async {
    emit(const AcceptContQrState.loadingState());
    final result =
        await _acceptContainersRepository.getContainersByAng(number: number);
    result.fold(
      (l) {
        emit(AcceptContQrState.errorState(message: mapFailureToMessage(l)));
      },
      (r) async {
        emit(AcceptContQrState.loadedState(containers: r));
        await _acceptContainersRepository.saveContainerNumberToCache(
          containerNumber: number,
        );
      },
    );
  }
}
