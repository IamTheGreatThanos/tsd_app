
import 'package:flutter/material.dart';

import 'month_view.dart';

class YearView extends StatelessWidget {
  const YearView({Key? key,
    required this.context,
    required this.year,
    required this.currentDateColor,
    this.highlightedDates,
    this.highlightedDateColor,
    this.monthNames,
    this.onMonthTap,
    this.monthTitleStyle,
  }) : super(key: key);

  final BuildContext context;
  final int year;
  final Color currentDateColor;
  final List<DateTime>? highlightedDates;
  final Color? highlightedDateColor;
  final List<String>? monthNames;
  final Function? onMonthTap;
  final TextStyle? monthTitleStyle;

  double get horizontalMargin => 16.0;
  double get monthViewPadding => 8.0;

  Widget buildYearMonths(BuildContext context) {
    final List<Row> monthRows = <Row>[];
    final List<MonthView> monthRowChildren = <MonthView>[];

    for (int month = 1; month <= DateTime.monthsPerYear; month++) {
      monthRowChildren.add(
        MonthView(
          context: context,
          year: year,
          month: month,
          padding: 0,
          currentDateColor: currentDateColor,
          highlightedDates: highlightedDates,
          highlightedDateColor: highlightedDateColor,
          monthNames: monthNames,
          onTap: onMonthTap,
          titleStyle: monthTitleStyle,
        ),
      );

      if (month % 2 == 0) {
        monthRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<MonthView>.from(monthRowChildren),
          ),
        );
        monthRowChildren.clear();
      }
    }

    return Column(
      children: List.from(monthRows),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: buildYearMonths(context),
            ),
          ],
        ),
      ),
    );
  }
}
