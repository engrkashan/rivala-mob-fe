import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/squads/create_new_squad.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/squads/squad_detail.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/create_new_link.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/image_stack.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class Squads extends StatefulWidget {
  const Squads({super.key});

  @override
  State<Squads> createState() => _SquadsState();
}

class _SquadsState extends State<Squads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,title: 'Squads', centerTitle: true),
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
                  row_widget(
                    onTap: () {
                      Get.to(()=>CreateNewSquad());
                    },
                    icon: Assets.imagesAdd3,
                    title: '  Start new squad',
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                    hint: 'Search squads',
                    prefixIcon: Image.asset(
                      Assets.imagesSearch,
                      width: 12,
                    ),
                    contentvPad: 5,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: squad_container(
                          delay: (index * 1) + 200,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class squad_container extends StatefulWidget {
  final String? date, amount, savedAmount;
  final int? delay;

  const squad_container({
    super.key,
    this.date,
    this.amount,
    this.savedAmount,
    this.delay,
  });

  @override
  State<squad_container> createState() => _squad_containerState();
}

class _squad_containerState extends State<squad_container> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: () {
        Get.to(() => SquadDetail());
      },
      widget: Animate(
        effects: [
          MoveEffect(delay: Duration(milliseconds: widget.delay ?? 100))
        ],
        child: CustomeContainer(
          color: kwhite,
          hpad: 10,
          hasShadow: true,
          radius: 15,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: 'Weekend Warriors',
                      size: 13,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Bounce_widget(
                      ontap: () {
                        setState(() {
                          isActive = !isActive;
                        });
                      },
                      widget: Icon(isActive == true
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_right_rounded))
                ],
              ),
              row_widget(
                icon: Assets.imagesAlert2,
                iconSize: 12,
                title: 'Inactive',
                textColor: kred,
                fontstyle: FontStyle.italic,
              ),
              SizedBox(
                height: 10,
              ),
              MyText(
                text: 'Description:',
                size: 11,
                weight: FontWeight.w500,
              ),
              MyText(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
                size: 11,
                weight: FontWeight.w500,
                paddingBottom: 10,
                paddingTop: 0,
              ),
              StackedImagesWidget(),
              if (isActive) ...{
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    buttonContainer(
                      text: 'Leave Squad',
                      bgColor: korange,
                      radius: 5,
                      vPadding: 4,
                      textsize: 11,
                      txtColor: kblack,
                        weight: FontWeight.normal,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    buttonContainer(
                      text: 'Delete Squad',
                      bgColor: kred,
                      radius: 5,
                      vPadding: 4,
                      textsize: 11,
                      txtColor: kblack,
                        weight: FontWeight.normal,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                MyText(
                  text: '> Edit squad',
                  size: 12,
                  color: kblue,
                  weight: FontWeight.w500,
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
