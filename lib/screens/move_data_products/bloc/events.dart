part of 'bloc_move_data.dart';

@immutable
abstract class EventBlocMoveData {}

class EventMoveDataInitial extends EventBlocMoveData {}

class EventChangeMoveData extends EventBlocMoveData {
  final int index;
  final int count;
  final String number;

  EventChangeMoveData({
    required this.index,
    required this.count,
    required this.number,
  });
}
