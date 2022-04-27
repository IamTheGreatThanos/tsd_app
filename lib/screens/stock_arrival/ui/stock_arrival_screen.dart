import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class StockArrivalScreen extends StatelessWidget {
  const StockArrivalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Приход на склад".toUpperCase(),
      ),
    );
  }
}
