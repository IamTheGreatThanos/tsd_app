import 'package:flutter/material.dart';

import 'package:pharmacy_arrival/widgets/custom_calendar/day_number.dart';
import 'package:pharmacy_arrival/widgets/custom_calendar/month_title.dart';
import 'package:pharmacy_arrival/widgets/custom_calendar/utils/dates.dart';

class MonthView extends StatelessWidget {
  const MonthView({
    super.key,
    required this.context,
    required this.year,
    required this.month,
    required this.padding,
    required this.currentDateColor,
    required this.onTap,
    this.highlightedDates,
    this.highlightedDateColor,
    this.monthNames,
    this.titleStyle,
  });

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final Color currentDateColor;
  final List<DateTime>? highlightedDates;
  final Color? highlightedDateColor;
  final List<String>? monthNames;
  final Function? onTap;
  final TextStyle? titleStyle;

  Color? getDayNumberColor(DateTime date) {
    Color? color;
    if (isCurrentDate(date)) {
      color = currentDateColor;
    } else if (highlightedDates != null &&
        isHighlightedDate(date, highlightedDates!)) {
      color = highlightedDateColor;
    }
    return color;
  }

  Widget buildMonthDays(BuildContext context) {
    final List<Row> dayRows = <Row>[];
    final List<DayNumber> dayRowChildren = <DayNumber>[];

    final int daysInMonth = getDaysInMonth(year, month);
    final int firstWeekdayOfMonth = DateTime(year, month).weekday;

    for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
      Color? color;
      if (day > 0) {
        color = getDayNumberColor(DateTime(year, month, day));
      }

      dayRowChildren.add(
        DayNumber(
          day: day,
          color: color,
          isLastDay: dayRowChildren.length == 6,
          onTap: () => onTap!.call(day, month, year),
        ),
      );

      if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(
          Row(
            children: List<DayNumber>.from(dayRowChildren),
          ),
        );
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MonthTitle(
            month: month,
            monthNames: monthNames,
            style: titleStyle!,
          ),
          Container(
            // padding: const EdgeInsets.all(8),
            // decoration: BoxDecoration(
            //   color: ColorPalette.blue,
            //   borderRadius: BorderRadius.circular(50)
            // ),
            margin: const EdgeInsets.only(top: 8.0),
            child: buildMonthDays(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      // onTap: () {
      //   onTap!(year, month);
      // },
      child: buildMonthView(context),
    );
  }
}
