part of 'bloc_return_data.dart';

@immutable
abstract class StateBlocReturnData {}

class StateReturnDataLoading extends StateBlocReturnData {}

class StateReturnDataError extends StateBlocReturnData {
  final String error;

  StateReturnDataError({required this.error});
}


class StateReturnDataLoadData extends StateBlocReturnData {
  final List<DTOReturnData> goods;

  StateReturnDataLoadData({required this.goods});
}
