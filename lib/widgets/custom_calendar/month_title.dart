import 'package:flutter/material.dart';

import 'package:pharmacy_arrival/widgets/custom_calendar/utils/dates.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    required this.month,
    this.monthNames,
    this.style = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  });

  final int month;
  final List<String>? monthNames;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      getMonthName(month,
          monthNames: monthNames ??
              [
                'Jan',
                'Feb',
                'Mar',
                'Apr',
                'May',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
                'Oct',
                'Nov',
                'Dec',
              ],),
      style: style,
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
    );
  }
}
