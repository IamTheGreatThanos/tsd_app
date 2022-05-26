part of 'bloc_goods_list.dart';

@immutable
abstract class EventBlocGoodsList {}

class EventInitialGoodsList extends EventBlocGoodsList {}

class EventScanItem extends EventBlocGoodsList {
  final String code;

  EventScanItem({
    required this.code,
  });
}
