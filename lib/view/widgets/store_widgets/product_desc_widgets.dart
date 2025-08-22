import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';

import '../my_text_widget.dart';

class PurchaseOptsWidget extends StatelessWidget {
  final String? title;
  final bool? hasDropdown;
  const PurchaseOptsWidget({super.key, this.title, this.hasDropdown});

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      borderColor: kheader,
      radius: 8,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: MyText(
                text: title ?? 'Subscription',
                size: 16,
                weight: FontWeight.w500,
                color: kheader,
                useCustomFont: true,
              )),
              CustomCheckBox(
                isActive: true,
                onTap: () {},
                iscircle: true,
                selectedColor: kwhite,
                unSelectedColor: ktransparent,
                bordercolor2: kblack,
                borderColor: kblack,
                iconColor: kblack,
              )
            ],
          ),
          if (hasDropdown == true)
            CustomDropDown(
                useCustomFont: true,
                radius: 8,
                bordercolor: kblack,
                hint: 'Frequency: Every month',
                items: [
                  'Every month',
                  'Frequency: Every month',
                  'Every two weeks'
                ],
                selectedValue: 'Frequency: Every month',
                onChanged: (e) {})
        ],
      ),
    );
  }
}

///QUANTITY WIGET

class ProductQuantity extends StatefulWidget {
  final double? vpad, hpad, iconSize, dpadv, dpadh, radius, midDistance;
  const ProductQuantity(
      {super.key,
      this.vpad,
      this.hpad,
      this.iconSize,
      this.dpadv,
      this.dpadh,
      this.radius,
      this.midDistance});

  @override
  State<ProductQuantity> createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  int quantity = 1;

  // Function to update quantity
  void updateQuantity(bool isIncrement) {
    setState(() {
      if (isIncrement) {
        quantity++;
      } else if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buttonContainer(
          bgColor: quantity > 1 ? kbutton : kgrey4,
          imagePath: Assets.imagesMinuss,
          imageSize: widget.iconSize ?? 24,
          vPadding: widget.vpad ?? 6,
          hPadding: widget.hpad ?? 6,
          iconColor: kbuttonText,
          radius: widget.radius ?? 8,
          onTap: () => updateQuantity(false),
          useCustomFont: true,
        ),
        SizedBox(
          width:widget.midDistance?? 10,
        ),
        buttonContainer(
          text: quantity.toString(),
          txtColor: kbutton,
          borderColor: kgrey4,
          bgColor: kbackground,
          vPadding: widget.dpadv ?? 10,
          hPadding: widget.dpadh ?? 15,
          iconColor: kbuttonText,
          radius: widget.radius ?? 8,
          useCustomFont: true,
        ),
        SizedBox(
             width:widget.midDistance?? 10,
        ),
        buttonContainer(
          bgColor: kbutton,
          imagePath: Assets.imagesAdd2,
          txtColor: kwhite,
          imageSize: widget.iconSize ?? 24,
          vPadding: widget.vpad ?? 6,
          hPadding: widget.hpad ?? 6,
          iconColor: kbuttonText,
          radius: widget.radius ?? 8,
          useCustomFont: true,
          onTap: () => updateQuantity(true),
        )
      ],
    );
  }
}

////
//MENU TILES

class CustomAccordion extends StatefulWidget {
  final String? title, desc;
  const CustomAccordion({
    Key? key,
    this.title,
    this.desc,
  }) : super(key: key);

  @override
  State<CustomAccordion> createState() => _CustomAccordionState();
}

class _CustomAccordionState extends State<CustomAccordion> {
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: kgrey4),
              top: BorderSide(color: kgrey4)),
          color: _isOpen ? kwhite : kwhite,
          //  border: Border.all(color: kbluewithopacity.withOpacity(0.5))
        ),
        child: Theme(
          data: ThemeData(
            dividerColor: kgrey2,
          ),
          child: ExpansionTile(
            title: MyText(
              text: widget.title ?? "Menu 1",
              size: 14,
              weight: FontWeight.w500,
              color: kheader,
              useCustomFont: true,
            ),
            backgroundColor: ktransparent,
            trailing: Icon(
              _isOpen ? Icons.remove : Icons.add,
              color: kheader,
            ),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    //  border: Border(bottom: BorderSide(color: kbutton),top: BorderSide(color: kbutton))
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(color: ktransparent),
                    ),
                    ListTile(
                        title: MyText(
                      text: widget.desc ??
                          'Lorem ipsum dolor sit amet consectetur. Sed dictum morbi odio nec tristique dictum eget. Aliquam duis convallis convallis id tincidunt lacus elit. Nibh turpis malesuada volutpat malesuada lacus facilisis morbi odio. Aliquet aliquet lobortis elit elit. ',
                      size: 13,
                      weight: FontWeight.w400,
                      color: kheader,
                      useCustomFont: true,
                    )),
                  ],
                ),
              ),
            ],
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
