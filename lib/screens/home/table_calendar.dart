import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class tableCalendar extends StatefulWidget {
  @override
  _tableCalendarState createState() => _tableCalendarState();
}

class _tableCalendarState extends State<tableCalendar> {
  CalendarController _calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      headerStyle: HeaderStyle(
          decoration: BoxDecoration(color: Colors.brown),
          headerMargin: EdgeInsets.only(bottom: 10.0),
          titleTextStyle: TextStyle(color: Colors.white),
          formatButtonTextStyle: TextStyle(color: Colors.white),
          formatButtonDecoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0)),
          leftChevronIcon: Icon(
            Icons.chevron_left_sharp,
            color: Colors.white,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right_sharp,
            color: Colors.white,
          )),
    );
  }
}
