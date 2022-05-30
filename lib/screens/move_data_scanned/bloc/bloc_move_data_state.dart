part of 'bloc_move_data_bloc.dart';

@immutable
abstract class StateBlocMoveData {}

class StateMoveDataLoading extends StateBlocMoveData {}

class StateMoveDataError extends StateBlocMoveData {
  final String error;

  StateMoveDataError({required this.error});
}

class StateMoveDataLoadData extends StateBlocMoveData {
  final List<DTOMoveData> goods;

  StateMoveDataLoadData({required this.goods});
}
