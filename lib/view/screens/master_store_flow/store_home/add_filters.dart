import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class AddFiltersDialog extends StatelessWidget {
  const AddFiltersDialog({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    return GestureDetector(
      onTap: () {
            Get.back();
      },
      child: Material(
        color: ktransparent,
        borderOnForeground: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2),
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.02), // Add opacity to background
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kwhite,
                        border: Border.all(color: ktransparent)),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ContainerAppbar(
                          title: 'Store Name',
                          isCenter: false,
                           useCustomFont: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            color: kgrey2,
                          ),
                        ),
                        CustomAccordion2(children: [
                          Row(
                            children: List.generate(
                              sizes.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: select_size_checkbox(
                                  title: sizes[index],
                                  isSelected: index == 0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ]),
                        CustomAccordion2(
                          title: 'Color',
                        ),
                        CustomAccordion2(
                          title: 'price',
                        ),
                        CustomAccordion2(
                          title: 'Availability',
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        MyButton(
                          outlineColor: kbutton,
                          fontColor: kbutton,
                          backgroundColor: kwhite,
                          buttonText: 'Apply filters',
                           useCustomFont: true,
                          onTap: () {
                                Get.back();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class select_size_checkbox extends StatelessWidget {
  final String? title;
  final bool? isSelected;
  const select_size_checkbox({
    super.key,
    this.title,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(
          isActive: isSelected == true ? true : false,
          onTap: () {},
          size: 15,
          selectedColor: kwhite,
          iconColor: kblack,
          circleIconsize: 14,
        ),
        MyText(
          text: title ?? 'S',
          weight: FontWeight.normal,
          size: 16,
          paddingLeft: 5,
          color: kblack,
           useCustomFont: true,
        )
      ],
    );
  }
}

///
class CustomAccordion2 extends StatefulWidget {
  final String? title, desc;
  final List<Widget>? children;

  const CustomAccordion2({
    Key? key,
    this.title,
    this.desc,
    this.children, // Accepting a list of widgets
  }) : super(key: key);

  @override
  State<CustomAccordion2> createState() => _CustomAccordion2State();
}

class _CustomAccordion2State extends State<CustomAccordion2> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: kgrey4)),
          color: _isOpen ? kwhite : kwhite,
        ),
        child: Theme(
          data: ThemeData(
            dividerColor: kgrey2,
          ),
          child: ExpansionTile(
            title: MyText(
              text: widget.title ?? "Availability",
              size: 14,
              weight: FontWeight.w500,
              color: kblack,
              useCustomFont: true,
            ),
            trailing: Icon(
              _isOpen
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_right_rounded,
              color: kblack,
            ),
            backgroundColor: ktransparent,
            children: widget.children ?? [],
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isOpen = expanded;
              });
            },
          ),
        ),
      ),
    );
  }
}
