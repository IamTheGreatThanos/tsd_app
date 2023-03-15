
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/counteragent_dto.dart';
import 'package:pharmacy_arrival/domain/usecases/get_organizations.dart';

part 'organization_state.dart';
part 'organization_cubit.freezed.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  final GetOrganizations _getOrganizations;
  OrganizationCubit(this._getOrganizations)
      : super(const OrganizationState.initialState());

  Future<void> loadOrganizations() async {
    emit(const OrganizationState.loadingState());
    final result = await _getOrganizations.call();
    result.fold(
        (l) =>
            emit(OrganizationState.errorState(message: mapFailureToMessage(l))),
        (r) {
      emit(OrganizationState.loadedState(organizations: r));
    });
  }
}
