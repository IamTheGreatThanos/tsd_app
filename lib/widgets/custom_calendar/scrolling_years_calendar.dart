import 'package:flutter/material.dart';

import 'utils/screen_sizes.dart';
import 'year_view.dart';

class ScrollingYearsCalendar extends StatefulWidget {
  ScrollingYearsCalendar({
    Key? key,
    required this.context,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.currentDateColor,
    this.highlightedDates,
    this.highlightedDateColor,
    this.monthNames,
    this.onMonthTap,
    this.monthTitleStyle,
  })  : assert(!initialDate.isBefore(firstDate),
            'initialDate must be on or after firstDate'),
        assert(!initialDate.isAfter(lastDate),
            'initialDate must be on or before lastDate'),
        assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate'),
        assert(highlightedDates == null || highlightedDateColor != null,
            'highlightedDateColor is required if highlightedDates is not null'),
        assert(
            monthNames == null || monthNames.length == DateTime.monthsPerYear,
            'monthNames must contain all months of the year'),
        super(key: key);

  final BuildContext context;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Color currentDateColor;
  final List<DateTime>? highlightedDates;
  final Color? highlightedDateColor;
  final List<String>? monthNames;
  final Function? onMonthTap;
  final TextStyle? monthTitleStyle;

  @override
  _ScrollingYearsCalendarState createState() => _ScrollingYearsCalendarState();
}

class _ScrollingYearsCalendarState extends State<ScrollingYearsCalendar> {
  YearView _getYearView(int year) {
    return YearView(
      context: context,
      year: year,
      currentDateColor: widget.currentDateColor,
      highlightedDates: widget.highlightedDates,
      highlightedDateColor: widget.highlightedDateColor,
      monthNames: widget.monthNames,
      onMonthTap: widget.onMonthTap,
      monthTitleStyle: widget.monthTitleStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int _itemCount = widget.lastDate.year - widget.firstDate.year + 1;
    final num _initialOffset =
        (widget.initialDate.year - widget.firstDate.year) *
            getYearViewHeight(context);
    final ScrollController _scrollController =
        ScrollController(initialScrollOffset: _initialOffset.toDouble());

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 0.0),
      controller: _scrollController,
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        final int year = index + widget.firstDate.year;
        return _getYearView(year);
      },
    );
  }
}
