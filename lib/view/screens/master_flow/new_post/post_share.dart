import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class PostShare extends StatefulWidget {
  const PostShare({super.key});

  @override
  State<PostShare> createState() => _PostShareState();
}

class _PostShareState extends State<PostShare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff404040),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 22),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Bounce_widget(
                    ontap: (){
                          Get.back();
                    },
                      widget: Image.asset(
                    Assets.imagesClose3,
                    width: 48,
                    height: 55,
                  ))),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: kblack.withOpacity(0.25),
                          blurRadius: 6,
                          spreadRadius: 4,
                          offset: Offset(4, 4),
                        ),
                      ]),
                      child: Image.asset(
                        Assets.imagesApolo,
                        width: 93,
                        height: 93,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: TwoTextedColumn(
                      text1: 'Apollo & Sage',
                      text2: '@apollo.and.sage',
                      size1: 22,
                      size2: 14,
                      color1: kwhite,
                      color2: kwhite,
                      weight1: FontWeight.bold,
                      weight2: FontWeight.w400,
                      alignment: ColumnAlignment.center,
                    ),
                  ),
                  MyText(
                    paddingBottom: 30,
                    paddingTop: 45,
                    text: 'Share “Blue Floral Short”',
                    size: 18,
                    weight: FontWeight.bold,
                    color: kwhite,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: CommonImageView(
                      imagePath: Assets.imagesQrcode,
                      width: 260,
                      radius: 15,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Expanded(
                            child: Bounce_widget(
                                widget: Image.asset(
                          Assets.imagesDownloadqr,
                          height: 65,
                        ))),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Bounce_widget(
                                widget: Image.asset(
                          Assets.imagesCopyqr,
                          height: 65,
                        )))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              Assets.imagesLogo1,
              color: kwhite,
              width: 45,
              height: 45,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
