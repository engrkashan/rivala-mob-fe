import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalender extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime date)? onDateSelected;

  const MyCalender({
    super.key,
    this.selectedDate,
    this.onDateSelected,
  });

  @override
  State<MyCalender> createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDate ?? DateTime.now();
    _focusedDay = _selectedDay;
  }

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
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      rowHeight: 35,
      sixWeekMonthsEnforced: false,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });

        /// 🔥 SEND DATE TO PARENT
        widget.onDateSelected?.call(selectedDay);
      },
      headerStyle: HeaderStyle(
        leftChevronVisible: false,
        rightChevronVisible: false,
        formatButtonVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, date) {
          return Row(
            children: [
              Expanded(
                child: MyText(
                  text: DateFormat.yMMMM().format(date),
                  color: kblack,
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: _onLeftChevronPressed,
                icon: Icon(Icons.keyboard_arrow_left, color: kblue),
              ),
              IconButton(
                onPressed: _onRightChevronPressed,
                icon: Icon(Icons.keyboard_arrow_right, color: kblue),
              ),
            ],
          );
        },
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: kblue.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: kblue.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
      ),
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
