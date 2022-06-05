import 'package:flutter/material.dart';
import 'package:pharmacy_arrival/styles/text_styles.dart';


class DayNumber extends StatelessWidget {
  const DayNumber({
    Key? key,
    required this.day,
    required this.isLastDay,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final int day;
  final Color? color;
  final bool isLastDay;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    final double width = sizes.width < 365 ? 15 : sizes.width > 420 ? 21 : 18;
    return Padding(
      padding: EdgeInsets.only(right: isLastDay ? 0 : 7.0),
      child: InkWell(
        onTap: () {
          if(day > 0) {
            onTap.call();
          }
        },
        child: Container(
          padding:  EdgeInsets.only(left: color != null ? 5 : 0,
              right: color != null ? 5 : 0,
              top: color != null ? 2 : 0,
              bottom: color != null ? 2 : 4,

          ),
          width: width,
          height: 23,
          alignment: Alignment.center,
          decoration: color != null
              ? BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(100),
                )
              : null,
          child: Text(
            day < 1 ? '' : day.toString(),
            textAlign: TextAlign.center,
            style: ThemeTextStyle.textStyle14w400.copyWith(color: color != null ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
