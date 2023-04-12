import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/repositories/accept_containers_repository.dart';

part 'refund_container_state.dart';
part 'refund_container_cubit.freezed.dart';

class RefundContainerCubit extends Cubit<RefundContainerState> {
  final AcceptContainersRepository acceptContainersRepository;

  RefundContainerCubit(this.acceptContainersRepository)
      : super(const RefundContainerState.initialState());

  Future<void> refundContainer({
    required List<String> names,
  }) async {
    emit(const RefundContainerState.loadingState());
    final result =
        await acceptContainersRepository.refundContainer(
          names: names,
        );
    result.fold((l) {
      emit( RefundContainerState.errorState(message: mapFailureToMessage(l)));
    }, (r) {
      emit( RefundContainerState.loadedState(message: r));
    });
  }
}
