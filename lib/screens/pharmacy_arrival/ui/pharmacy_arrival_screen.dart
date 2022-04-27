import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/widgets/custom_app_bar.dart';

class PharmacyArrivalScreen extends StatelessWidget {
  const PharmacyArrivalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Приход аптека".toUpperCase(),
      ),
    );
  }
}
