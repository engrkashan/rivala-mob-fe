import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/products_added_success.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/switch_button.dart';

class ImportCsv extends StatefulWidget {
  const ImportCsv({super.key});

  @override
  State<ImportCsv> createState() => _ImportCsvState();
}

class _ImportCsvState extends State<ImportCsv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(context: context,title: 'Import Products', centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                ProductTable(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyText(
                        text: 'Apply 15% commission to all products',
                        size: 15,
                        color: kblack,
                        weight: FontWeight.w500,
                      ),
                    ),
                    SwitchButton(
                      scale: 0.6,
                      isActive: true,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyButton(
        buttonText: 'Add products',
        mhoriz: 22,
        mBottom: 50,
        onTap: () {
          Get.to(()=>ProductsAddedSuccess());
        },
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  final List<Map<String, dynamic>> tableData = [
    {
      'attribute': 'Size',
      'checked': true,
      'price': '\$25.99',
      'available': 'Yes',
      'onHand': '1,200',
      'sku': 'ATH-SNK-BLK-10',
    },
    {
      'attribute': 'Color',
      'checked': true,
      'price': '\$25.99',
      'available': 'No',
      'onHand': '5,000',
      'sku': 'ORG-CFL-500ML',
    },
    {
      'attribute': 'Fabric',
      'checked': true,
      'price': '\$50.99',
      'available': 'Edit',
      'onHand': '251',
      'sku': 'LTH-BLT-BLK-32',
    },
    {
      'attribute': 'Fabric',
      'checked': false,
      'price': '\$50.99',
      'available': 'Edit',
      'onHand': '251',
      'sku': 'LTH-BLT-BLK-32',
    },
    {
      'attribute': 'Fabric',
      'checked': false,
      'price': '\$50.99',
      'available': 'Edit',
      'onHand': '251',
      'sku': 'LTH-BLT-BLK-32',
    },
    {
      'attribute': 'Fabric',
      'checked': false,
      'price': '\$50.99',
      'available': 'Edit',
      'onHand': '251',
      'sku': 'LTH-BLT-BLK-32',
    },
    {
      'attribute': 'Fabric',
      'checked': false,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          // ✅ Header Row
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: const [
                SizedBox(width: 90), // Skip header for icon+attribute
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
                    width: 90,
                    child: Row(
                      children: [
                        Icon(
                          row['checked'] ? Icons.check_circle : Icons.add,
                          color: row['checked'] ? Colors.green : Colors.black,
                          size: 22,
                        ),
                        const SizedBox(width: 6),
                        MyText(
                          text: row['attribute'],
                          size: 11,
                          weight: FontWeight.bold,
                          color: kblack,
                        ),
                      ],
                    ),
                  ),
                  // Price
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 6),
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
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: getAvailabilityColor(row['available']),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child:
                        MyText(text: row['available'], color: kblack, size: 10),
                  ),
                  const SizedBox(width: 10),
                  // On Hand
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 6),
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
                    padding: const EdgeInsets.symmetric(vertical: 6),
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
    );
  }
}

// ✅ Custom Header Cell Widget
class HeaderCell extends StatelessWidget {
  final String text;
  final double width;
  const HeaderCell({required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: MyText(
        text: text,
        size: 11,
        textAlign: TextAlign.center,
        weight: FontWeight.normal,
        color: kblack,
      ),
    );
  }
}
