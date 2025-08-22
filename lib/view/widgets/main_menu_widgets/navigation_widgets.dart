import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class navigation_info_container extends StatefulWidget {
  final String? title, img;

  const navigation_info_container({super.key, this.title, this.img});

  @override
  State<navigation_info_container> createState() =>
      _navigation_info_containerState();
}

class _navigation_info_containerState extends State<navigation_info_container> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
          color: Colors.red,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: MyText(
          text: 'Delete',
          color: kblack,
          size: 15,
          weight: FontWeight.w500,
        ),
      ),
      onDismissed: (direction) {
        // Handle deletion logic here
      },
      child: CustomeContainer(
        color: kgrey2,
        vpad: 5,
        hpad: 12,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: isActive
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesMenu2,
                  width: 10,
                  height: 11,
                ),
                SizedBox(
                  width: 8,
                ),
                store_image_stack(
                  width: 45,
                  height: 45,
                  iconSize: 12,
                  radius: 8,
                  showContent: false,
                  showShadow: false,
                  icon: Assets.imagesCollection4,
                ),
                Expanded(
                  child: isActive
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: widget.title ?? 'Womens',
                                size: 15,
                                weight: FontWeight.w500,
                                color: kblack,
                              ),
                              navigation_inner_row(),
                              SizedBox(
                                height: 5,
                              ),
                              navigation_inner_row(
                                textt: 'Euro Shorts',
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              navigation_inner_row(
                                textt: 'Weekend Warriors',
                                icon: Assets.imagesMembers,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  buttonContainer(
                                    bgColor: kgreen,
                                    hPadding: 4,
                                    vPadding: 1,
                                    text: 'Add Sub-Menu',
                                    radius: 8,
                                    txtColor: kblack,
                                    textsize: 10,
                                    weight: FontWeight.normal,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : MyText(
                          text: widget.title ?? 'Womens',
                          size: 15,
                          weight: FontWeight.w500,
                          color: kblack,
                          paddingLeft: 8,
                        ),
                ),
                Bounce_widget(
                    ontap: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    widget: Icon(
                      isActive
                          ? Icons.keyboard_arrow_down_rounded
                          : Icons.keyboard_arrow_right_rounded,
                      color: kblack,
                    ))
              ],
            ),
      
          ],
        ),
      ),
    );
  }
}

class navigation_inner_row extends StatelessWidget {
  final String? textt, icon;
  const navigation_inner_row({
    super.key,
    this.textt,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        row_widget(
          title: textt ?? 'Swim Trunks',
          icon: icon ?? Assets.imagesSave,
          iconSize: 10,
          texSize: 10,
          weight: FontWeight.normal,
          isIconRight: true,
        ),
        buttonContainer(
          bgColor: kred,
          hPadding: 4,
          vPadding: 1,
          text: 'Remove',
          radius: 8,
          txtColor: kblack,
          textsize: 10,
          weight: FontWeight.normal,
        )
      ],
    );
  }
}

//////////////////


