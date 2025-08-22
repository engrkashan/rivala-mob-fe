import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/font_customisation/font_customization.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';



class Fontselection extends StatelessWidget {
  final String? title;
  final String fontFamily;
  final FontController fontController = Get.find();

  Fontselection({
    super.key,
    this.title,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: MyText(
            text: title ?? 'Formal',
            color: ktertiary,
            size: 14,
          ),
        ),
        Obx(
          () {
            bool isActive = fontController.selectedFont.value == fontFamily;
            return Bounce_widget(
              ontap: () async{
                fontController.selectFont(fontFamily);

                await fontController.loadFonts(fontFamily);
                  print(fontController.selectedFont.value);
              },
              widget: CustomeContainer(
                borderColor: isActive ? kgreen : ktertiary,
                color: isActive ? kgreen.withOpacity(0.05) : ktransparent,
                radius: 15,
                widget: Row(
                  children: [
                    TwoTextedColumn(
                      text1: 'Ag',
                      text2: 'Header',
                      size1: 40,
                      size2: 10,
                      alignment: ColumnAlignment.center,
                      fontFamily: fontFamily,
                    ),
                    SizedBox(width: 10),
                    TwoTextedColumn(
                      text1: 'Ag',
                      text2: 'Header',
                      size1: 30,
                      size2: 10,
                      alignment: ColumnAlignment.center,
                      fontFamily: fontFamily,
                    ),
                    SizedBox(width: 10),
                    TwoTextedColumn(
                      text1: 'Ag',
                      text2: 'Header',
                      size1: 20,
                      size2: 10,
                      alignment: ColumnAlignment.center,
                      fontFamily: fontFamily,
                    ),
                    SizedBox(width: 10),
                    TwoTextedColumn(
                      text1: 'Ag',
                      text2: 'Header',
                      size1: 10,
                      size2: 10,
                      alignment: ColumnAlignment.center,
                      fontFamily: fontFamily,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

