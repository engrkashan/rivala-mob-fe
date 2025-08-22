import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/create_new_link.dart';
import 'package:rivala/view/widgets/animate_widgets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class IndiviualLink extends StatefulWidget {
  const IndiviualLink({super.key});

  @override
  State<IndiviualLink> createState() => _IndiviualLinkState();
}

class _IndiviualLinkState extends State<IndiviualLink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Instagram', centerTitle: true, actions: [
          Bounce_widget(
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
                  MyTextField(
                    hint: 'Instagram',
                    label: 'Link Name',
                    hintColor: ktertiary,
                    delay: 200,
                    bordercolor: ktertiary,
                  ),
                  MyTextField(
                    hint: 'instagram.com/austinlarsen27',
                    label: 'URL',
                    delay: 400,
                    hintColor: ktertiary,
                    bordercolor: ktertiary,
                  ),
             SlideAnimation(
              delay: 600,
                    child: MyText(
                        text: 'Link Thumbnail',
                        size: 15,
                        paddingBottom: 8,
                        weight: FontWeight.w500,
                        color: kblack),
                  ),

              SlideAnimation(
                delay: 700,
                    child: Bounce_widget(
                      ontap: () {},
                      widget: CustomeContainer(
                        height: 188,
                        color: kgrey4,
                        radius: 15,
                        mtop: 0,
                        widget: Center(
                            child: Image.asset(
                          Assets.imagesExportt,
                          width: 70,
                          height: 69,
                        )),
                      ),
                    ),
                  ),
                  SlideAnimation(
                    delay: 750,
                    child: MyText(
                        paddingTop: 30,
                        text: 'Remove link',
                        size: 15,
                        paddingBottom: 8,
                        weight: FontWeight.w400,
                        color: kred),
                  ),
                ],
              ),
            ),
            MyButton(
              buttonText: 'Save link',
              mBottom: 80,
              mhoriz: 35,
              onTap: () {
                Get.to(() => CreateNewLink());
              },
            ),
          ],
        ));
  }
}
