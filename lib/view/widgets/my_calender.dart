import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import 'package:table_calendar/table_calendar.dart';

class MyCalender extends StatefulWidget {
  const MyCalender({super.key});

  @override
  State<MyCalender> createState() => _MyCalenderState();
}

DateTime _focusedDay = DateTime.now(); // Track the currently focused day
DateTime _selectedDay = DateTime.now(); // Track the currently selected day

class _MyCalenderState extends State<MyCalender> {
  void _onLeftChevronPressed() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
    });
  }

  void _onRightChevronPressed() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      // rangeStartDay: DateTime.now(),
      // rangeEndDay: DateTime.utc(2024, 12, 6),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      rowHeight: 35,
      sixWeekMonthsEnforced: false,
      headerStyle: HeaderStyle(
        leftChevronVisible: false,
        titleCentered: false,
        rightChevronVisible: false,
        formatButtonVisible: false,
        titleTextFormatter: (date, locale) =>
            DateFormat.yMMMM(locale).format(date),
        headerPadding: EdgeInsets.symmetric(vertical: 8), // Adjust padding
        leftChevronIcon: SizedBox.shrink(), // Hide default left arrow
        rightChevronIcon: SizedBox.shrink(), // Hide default right arrow
        headerMargin: EdgeInsets.all(0),

        // titleTextStyle: TextStyle(
        //   color: kblack,
        //   fontSize: 13,
        //   fontWeight: FontWeight.w700,
        //   fontFamily: AppFonts.poppins,
        // ),
      ),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, date) {
          return Row(
            children: [
              // Month Title
              Expanded(
                child: Row(
                  children: [
                    MyText(
                      text: '${DateFormat.yMMMM().format(date)}',
                      color: kblack,
                      size: 16,
                      weight: FontWeight.w500,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: kblue,
                      size: 18,
                    )
                  ],
                ),
              ),
              // Chevron buttons
              Row(
                children: [
                  IconButton(
                      onPressed: _onLeftChevronPressed,
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: kblue,
                      )),
                  IconButton(
                      onPressed: _onRightChevronPressed,
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        color: kblue,
                      )),
                ],
              ),
            ],
          );
        },
      ),
      calendarStyle: CalendarStyle(
        // rangeHighlightColor: kblue,
        // rangeStartDecoration: BoxDecoration(
        //   color: kblue,
        //   shape: BoxShape.circle,
        // ),
        selectedTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xff007AFF),
          fontFamily: AppFonts.poppins,
        ),
        selectedDecoration: BoxDecoration(
          color: kblue.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        cellMargin: EdgeInsets.all(5),
        cellPadding: EdgeInsets.all(0),
        withinRangeTextStyle: TextStyle(color: kwhite),
        withinRangeDecoration: BoxDecoration(shape: BoxShape.circle),
        rangeEndDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kblue,
        ),
        defaultTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: kblack.withOpacity(0.8),
          fontFamily: AppFonts.poppins,
        ),
        todayTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xff007AFF),
          fontFamily: AppFonts.poppins,
        ),
        weekendTextStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: kblack.withOpacity(0.8),
          fontFamily: AppFonts.poppins,
        ),
        todayDecoration: BoxDecoration(
          color: kblue.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.poppins,
          color: kgrey3,
        ),
        dowTextFormatter: (date, locale) {
          return DateFormat.E(locale)
              .format(date); // Displays "Sun", "Mon", etc.
        },
        weekendStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: AppFonts.poppins,
          color: kgrey3,
        ),
      ),

      selectedDayPredicate: (day) {
        // Select the day when it is tapped
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay; // Update the focused day
        });
      },
    );
  }
}

/////////////
class calender_row extends StatelessWidget {
  final String? title, time;
  const calender_row({
    super.key,
    this.title,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: kgrey2),
              bottom: BorderSide(color: kgrey2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            color: kblack,
            weight: FontWeight.w500,
            text: title ?? 'Ends',
            size: 16,
          ),
          buttonContainer(
            text: time ?? '8:00 AM',
            vPadding: 6,
            txtColor: kblack,
            weight: FontWeight.normal,
            radius: 8,
            bgColor: ktertiary.withOpacity(0.05),
          )
        ],
      ),
    );
  }
}
