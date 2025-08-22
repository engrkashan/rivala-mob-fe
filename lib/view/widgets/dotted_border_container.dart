import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class DottedBorderContainer extends StatelessWidget {
  final String? title,icon;
  final VoidCallback? ontap;
  final double? vpad,hpad;
  const DottedBorderContainer({
    super.key, this.title, this.icon, this.ontap, this.vpad, this.hpad,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap??(){},
      widget: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: [15, 9],
          color: ktertiary,
          radius: Radius.circular(15),
          padding:
              EdgeInsets.symmetric(vertical:vpad?? 20, horizontal:hpad?? 15),
          child: Row(
            children: [
              if(icon!=null)
              Image.asset(
              icon??  Assets.imagesLinktree,
                width: 35,
                height: 35,
              ),
              Expanded(
                  child: MyText(
                text:title?? 'Import from LinkTree',
                size: 15,
                weight: FontWeight.w500,
                paddingLeft: 15,
                color: kblue,
              )),
            ],
          )),
    );
  }
}
