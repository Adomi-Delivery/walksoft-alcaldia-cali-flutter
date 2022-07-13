import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

Widget createCalendar() {
  DateTime _focusedDay = DateTime.now();
  final kFirstDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final kLastDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime? _selectedDay;

  return TableCalendar(
    firstDay: kFirstDay,
    lastDay: kLastDay,
    focusedDay: _focusedDay,
    calendarFormat: CalendarFormat.month,
    selectedDayPredicate: (day) {
      return isSameDay(_selectedDay, day);
    },
  );
}
