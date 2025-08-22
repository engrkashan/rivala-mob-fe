import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_flow/new_post/tag_collection/tag_collection.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';

class ReportIisue extends StatefulWidget {
  const ReportIisue({super.key});

  @override
  State<ReportIisue> createState() => _ReportIisueState();
}

class _ReportIisueState extends State<ReportIisue> {
  final List reports=[
    'I just don’t like it',
    'Bullying or unwanted contact',
    'Suicide, self-injury or eating disorders',
    'Violence, hate, or exploitation',
    'Selling or promoting restricted items',
    'Nudity or sexual activity',
    'False information'
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
          body: ImageLayoutWidget(
            bodyWidget: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ContainerAppbar(
                    title: 'Report This Post',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Divider(
                    color: kgrey2,
                  ),
                ),
                MyText(
                  text: 'Why are you reporting this post?',
                  size: 19,
                  color: kred,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  paddingLeft: 18,
                  paddingRight: 18,
                  useCustomFont: true,
                  paddingBottom: 3,
                ),
                   MyText(
                  text: 'Your report is anonymous. If someone is in immediate danger, call the local emergency services – don’t wait.',
                  size: 12,
                  color: kbody,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  paddingLeft: 18,
                  paddingRight: 18,
                  useCustomFont: true,
                ),

                    ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Column(
                          children: [
                            icon_text_row(
                              hasIcon: false,
                              title:reports[index] ,
                              textSize: 14,
                              weight: FontWeight.w600,
                              bgColor: ktransparent,
                              useCustomFont: true,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: Divider(color: kgrey2,),
                            )
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20,),
                  Mybutton2(
                    buttonText: 'Report',
                    useCustomFont: true,
                    bgColor: kwhite,
                    borderColor: kbutton,
                    fontColor: kbutton,
                       ontap: (){
                                Get.back();
                          },
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
