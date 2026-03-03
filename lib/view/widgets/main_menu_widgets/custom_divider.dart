import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class CustomDivider extends StatelessWidget {
  final VoidCallback? ontap;
  const CustomDivider({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 3,
          color: kblue,
          height: 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bounce_widget(
              duration: 100,
              ontap: ontap,
              widget: Container(
                decoration: BoxDecoration(
                    color: kblue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Center(
                    child: MyText(
                  text: 'Add section',
                  color: kblack,
                  weight: FontWeight.bold,
                  size: 10,
                )),
              ),
            )
          ],
        ),
      ],
    );
  }
}
