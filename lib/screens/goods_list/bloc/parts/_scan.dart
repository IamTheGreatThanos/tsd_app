// part of "../bloc_goods_list.dart";

// extension Scan on BlocGoodsList{
//   Future<void> _scan(EventScanItem event, Emitter<StateBlocGoodsList> emit) async{
//     List<GoodDetails> good = goods.where((element) => element.number == event.code).toList();
//     if(good.isNotEmpty){
//       scannedGoods.add(good.first);
//       goods.removeWhere((element) => element.number == event.code);
//       emit(StateGoodScanned(code: event.code));
//       emit(StateGoodsListLoadData(goods: GoodsResponse(unscannedProducts: goods, scannedProducts: scannedGoods)));
//     }
//     else{
//       emit(StateGoodNotFound(code: event.code));
//     }
//   }
// }