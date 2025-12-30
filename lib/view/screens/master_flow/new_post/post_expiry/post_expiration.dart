import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_calender.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../controllers/providers/post_provider.dart';

class PostExpiration extends StatefulWidget {
  const PostExpiration({super.key});

  @override
  State<PostExpiration> createState() => _PostExpirationState();
}

class _PostExpirationState extends State<PostExpiration> {
  final List suggestions = ['Fall Fashion', 'Hidden Gems', 'Jackets'];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Create collection',
            centerTitle: true,
            actions: [
              Bounce_widget(
                  ontap: () {
                    Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesClose,
                    width: 18,
                    height: 18,
                  )),
              SizedBox(
                width: 12,
              )
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  MyText(
                      color: ktertiary,
                      weight: FontWeight.w400,
                      text:
                          'Set a date and time if you’d like the post to be shared for a limited time. You will still be able to access the post once it has expired. ',
                      size: 16,
                      paddingBottom: 35),
                  MyTextField(
                    controller: dateController,
                    bordercolor: kblack,
                    hint: 'Select date & time',
                    hintColor: kblack,
                    radius: 50,
                    readOnly: true,
                    ontapp: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (date == null) return;

                      final time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                      );

                      if (time == null) return;

                      setState(() {
                        selectedDate = date;
                        selectedTime = time;
                        dateController.text =
                            '${date.month}/${date.day}/${date.year}, ${time.format(context)}';
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: MyCalender(
                      selectedDate: selectedDate,
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                  ),
                  calender_row()
                ],
              ),
            ),
            Mybutton2(
              buttonText2: 'Cancel',
              buttonText: 'Done',
              mbot: 30,
              hpad: 22,
              ontap2: () {
                Get.back();
              },
              ontap: () {
                if (selectedDate == null || selectedTime == null) {
                  Get.snackbar('Missing info', 'Please select date & time');
                  return;
                }

                final dateTime = DateTime(
                  selectedDate!.year,
                  selectedDate!.month,
                  selectedDate!.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );

                context.read<PostProvider>().setPostExpiration(dateTime);

                Get.back();
              },
            ),

          ],
        ));
  }
}
