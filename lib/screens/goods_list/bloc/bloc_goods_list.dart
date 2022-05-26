import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

class BlocGoodsList extends Bloc<EventBlocGoodsList, StateBlocGoodsList> {
  BlocGoodsList() : super(StateGoodsListLoading()) {
    on<EventInitialGoodsList>((event, emit) {
      List<GoodDetails> goods = [];
      for (int i = 0; i < 15; i++) {
        goods.add(
          GoodDetails(
              image:
                  "assets/images/png/goos_sample_${Random().nextBool() ? "1" : "2"}.png",
              title:
                  "${Random().nextBool() ? "Акнекутан капс. 16мг №30" : "Оптинол Глубокое увлажнение 0,4% 10мл"}",
              company: "Jadran",
              count: Random().nextInt(250),
              number: "${Random().nextBool() ? "292U10" : "110115"}"),
        );
      }
      emit(StateGoodsListLoadData(goodsResponse: GoodsResponse(goods: goods)));
    });
  }
}

class GoodsResponse {
  int price;
  List<GoodDetails> goods;

  GoodsResponse({required this.goods, this.price = 255000});
}

class GoodDetails {
  final String image;
  final String title;
  final String company;
  final int count;
  final String number;
  int price;

  GoodDetails({
    required this.image,
    required this.title,
    required this.company,
    required this.count,
    required this.number,
    this.price = 5000,
  });
}
