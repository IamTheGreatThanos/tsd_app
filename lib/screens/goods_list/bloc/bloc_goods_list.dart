import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

part 'parts/_read.dart';

part 'parts/_scan.dart';

class BlocGoodsList extends Bloc<EventBlocGoodsList, StateBlocGoodsList> {
  BlocGoodsList() : super(StateGoodsListLoading()) {
    on<EventInitialGoodsList>(_read);
    on<EventScanItem>(_scan);
  }

  List<GoodDetails> goods = [];
  List<GoodDetails> scannedGoods = [];
}

class GoodsResponse {
  int get totalPrice {
    int total = 0;
    for (var element in goods) {
      total += element.price;
    }
    for (var element in scannedGoods) {
      total += element.price;
    }
    return total;
  }

  int get totalScannedPrice {
    int total = 0;
    for (var element in scannedGoods) {
      total += element.price;
    }
    return total;
  }

  List<GoodDetails> goods;
  List<GoodDetails> scannedGoods;

  GoodsResponse({
    required this.goods,
    required this.scannedGoods,
  });
}

class GoodDetails {
  final String image;
  final String title;
  final String company;
  final int count;
  final String number;
  final int price;

  GoodDetails({
    required this.image,
    required this.title,
    required this.company,
    required this.count,
    required this.number,
    required this.price,
  });
}
