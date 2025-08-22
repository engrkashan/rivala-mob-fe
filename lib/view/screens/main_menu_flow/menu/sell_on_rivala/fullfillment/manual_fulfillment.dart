import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class ManualFulfillment extends StatefulWidget {
  const ManualFulfillment({super.key});

  @override
  State<ManualFulfillment> createState() => _ManualFulfillmentState();
}

class _ManualFulfillmentState extends State<ManualFulfillment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context,
          title: 'New fulfillment provider', centerTitle: true, size: 16),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            color: kgrey2,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                CustomeContainer(
                  radius: 10,
                  vpad: 11,
                  hpad: 11,
                  borderColor: korange,
                  widget: row_widget(
                    title: 'Verification sync failure',
                    textColor: korange,
                    icon: Assets.imagesAlert,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomDropDown(
                  hint: 'Shipstation',
                  items: ['Shipstation', 'Shipstation2'],
                  selectedValue: 'Shipstation',
                  onChanged: (s) {},
                  label: 'Fulfillment Type',
                  bgColor: ktransparent,
                  bordercolor: kgrey3,
                  radius: 8,
                  vpad: 11,
                  hintsize: 14,
                ),
                MyTextField(
                  bordercolor: kgrey3,
                  filledColor: ktransparent,
                  hint: 'Enter name...',
                  label: 'Fulfillment Name',
                  radius: 8,
                  contentvPad: 11,
                  hintColor: ktertiary,
                  hintSize: 14,
                  suffixIcon: Image.asset(
                    Assets.imagesEdit5,
                    width: 18,
                  ),
                ),
                MyTextField(
                  bordercolor: kgrey3,
                  filledColor: ktransparent,
                  hint: 'Enter key...',
                  label: 'ShipStation API key',
                  radius: 8,
                  contentvPad: 11,
                  hintColor: ktertiary,
                  hintSize: 14,
                  suffixIcon: Image.asset(
                    Assets.imagesEdit5,
                    width: 18,
                  ),
                ),
                MyTextField(
                  bordercolor: kgrey3,
                  filledColor: ktransparent,
                  hint: 'Enter secret...',
                  label: 'ShipStation Secret',
                  radius: 8,
                  contentvPad: 11,
                  hintColor: ktertiary,
                  hintSize: 14,
                  suffixIcon: Image.asset(
                    Assets.imagesEdit5,
                    width: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Mybutton2(
        buttonText: 'Verify',
        hpad: 22,
        mbot: 60,
      ),
    );
  }
}
