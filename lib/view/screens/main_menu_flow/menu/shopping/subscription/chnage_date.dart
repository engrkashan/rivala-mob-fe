import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/my_calender.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class ChnageDate extends StatefulWidget {
  const ChnageDate({super.key});

  @override
  State<ChnageDate> createState() => _ChnageDateState();
}

class _ChnageDateState extends State<ChnageDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: kwhite),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerAppbar(
            title: 'Change Processing Date',
            textColor: kblack,
          ),
          Container(
            height: 300,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MyCalender(),
          ),
          calender_row(
            title: 'Starts',
          ),
          calender_row(),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}

