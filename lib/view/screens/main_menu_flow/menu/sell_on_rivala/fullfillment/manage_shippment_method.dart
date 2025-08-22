import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/switch_button.dart';

class ManageShippmentMethod extends StatefulWidget {
  const ManageShippmentMethod({super.key});

  @override
  State<ManageShippmentMethod> createState() => _ManageShippmentMethodState();
}

class _ManageShippmentMethodState extends State<ManageShippmentMethod> {
  List<Map<String, dynamic>> items = [
    {
      'title': 'UPS Ground',
      'icon': Assets.imagesUps,
      'active': true,
    },
    {
      'title': 'UPS Next Day',
      'icon': Assets.imagesUps,
      'active': false,
    },
    {
      'title': 'USPS',
      'icon': Assets.imagesUsps,
      'active': false,
    },
    {
      'title': 'Amazon FBA',
      'icon': Assets.imagesAmazon2,
      'active': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context,
          title: 'Manage shipping methods', centerTitle: true, size: 16),
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
                Align(
                  alignment: Alignment.topRight,
                  child: Bounce_widget(
                      widget: Image.asset(
                    Assets.imagesReverse,
                    width: 36,
                    height: 30,
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: manage_shippment_row(
                        title: item['title'],
                        icon: item['icon'],
                        isActive: item['active'],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Mybutton2(
        buttonText: 'Save',
        hpad: 22,
        mbot: 60,
      ),
    );
  }
}

class manage_shippment_row extends StatelessWidget {
  final String? title, icon;
  final bool? isActive;
  const manage_shippment_row({
    super.key,
    this.title,
    this.icon,
    this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomeContainer(
          vpad: 10,
          hpad: 12,
          color: kgreyy.withOpacity(0.35),
          radius: 10,
          widget: Center(
              child: Image.asset(
            icon ?? Assets.imagesUps,
            width: 24,
            height: 28,
          )),
        ),
        Expanded(
            child: MyText(
          text: title ?? 'UPS Ground',
          size: 15,
          weight: FontWeight.w500,
          color: kblack,
          paddingLeft: 8,
        )),
        SwitchButton(
          isActive: isActive ?? true,
          scale: 0.85,
        )
      ],
    );
  }
}
