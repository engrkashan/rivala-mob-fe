import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/import_csv.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class AddAttribute extends StatelessWidget {
  const AddAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tableData = [
      {
        'attribute': 'Size',
        'price': '\$25.99',
        'available': 'Yes',
        'onHand': '1,200',
        'sku': 'ATH-SNK-BLK-10',
      },
      {
        'attribute': 'Color',
        'price': '\$25.99',
        'available': 'No',
        'onHand': '5,000',
        'sku': 'ORG-CFL-500ML',
      },
      {
        'attribute': 'Fabric',
        'price': '\$50.99',
        'available': 'Edit',
        'onHand': '251',
        'sku': 'LTH-BLT-BLK-32',
      },
    ];
    Color getAvailabilityColor(String status) {
      switch (status) {
        case 'Yes':
          return kgreen;
        case 'No':
          return kred;
        default:
          return ktertiary;
      }
    }

    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: kwhite),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ContainerAppbar(
                  title: 'Variants',
                  textColor: kblack,
                  icon: Assets.imagesClose2
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                  hint: 'Size',
                  label: 'Variant Name',
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      // ✅ Header Row
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: const [
                            SizedBox(
                                width: 90), // Skip header for icon+attribute
                            HeaderCell(text: 'Price', width: 80),
                            SizedBox(width: 10),
                            HeaderCell(text: 'Available', width: 60),
                            SizedBox(width: 10),
                            HeaderCell(text: 'On Hand', width: 60),
                            SizedBox(width: 10),
                            HeaderCell(text: 'SKU', width: 100),
                          ],
                        ),
                      ),

                      // ✅ Data Rows
                      ...tableData.map((row) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              // Attribute Cell
                              SizedBox(
                                width: 70,
                                child: MyText(
                                  text: row['attribute'],
                                  size: 11,
                                  weight: FontWeight.bold,
                                  color: kblack,
                                ),
                              ),
                              // Price
                              Container(
                                width: 80,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: kgrey2,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: MyText(text: row['price'], size: 10),
                              ),
                              const SizedBox(width: 10),
                              // Available
                              Container(
                                width: 60,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: getAvailabilityColor(row['available']),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: MyText(
                                    text: row['available'],
                                    color: kblack,
                                    size: 10),
                              ),
                              const SizedBox(width: 10),
                              // On Hand
                              Container(
                                width: 60,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: kgrey2,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: MyText(text: row['onHand'], size: 10),
                              ),
                              const SizedBox(width: 10),
                              // SKU
                              Container(
                                width: 100,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: kgrey2,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: MyText(text: row['sku'], size: 10),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                MyText(
                  text: '+ Add variant',
                  color: kblue,
                  weight: FontWeight.w500,
                  size: 12,
                  paddingBottom: 30,
                  paddingTop: 20,
                ),
                MyButton(
                  buttonText: 'Save variant',
                  mBottom: 30,
                )
              ],
            ))));
  }
}
