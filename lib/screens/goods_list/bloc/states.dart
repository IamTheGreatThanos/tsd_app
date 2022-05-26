part of 'bloc_goods_list.dart';

@immutable
abstract class StateBlocGoodsList {}

class StateGoodsListLoading extends StateBlocGoodsList {}

class StateGoodsListLoadData extends StateBlocGoodsList {
  final GoodsResponse goodsResponse;

  StateGoodsListLoadData({
    required this.goodsResponse,
  });
}
