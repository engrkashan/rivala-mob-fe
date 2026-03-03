import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/import_csv.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class AddAttribute extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  const AddAttribute({super.key, this.initialData});

  @override
  State<AddAttribute> createState() => _AddAttributeState();
}

class _AddAttributeState extends State<AddAttribute> {
  late TextEditingController nameCtrl;
  List<Map<String, dynamic>> variants = [];

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.initialData?['name'] ?? '');
    if (widget.initialData?['variants'] != null) {
      variants =
          List<Map<String, dynamic>>.from(widget.initialData!['variants']);
    } else {
      // Add one empty row by default
      _addVariant();
    }
  }

  void _addVariant() {
    setState(() {
      variants.add({
        'attribute': '',
        'price': '',
        'available': 'Yes',
        'onHand': '',
        'sku': '',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: Assets.imagesClose2),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: nameCtrl,
                  hint: 'e.g. Size or Color',
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
                            HeaderCell(text: 'Value', width: 90),
                            SizedBox(width: 10),
                            HeaderCell(text: 'Price', width: 80),
                            SizedBox(width: 10),
                            HeaderCell(text: 'Available', width: 60),
                            SizedBox(width: 10),
                            HeaderCell(text: 'On Hand', width: 60),
                            SizedBox(width: 10),
                            HeaderCell(text: 'SKU', width: 100),
                            SizedBox(width: 30), // Match delete icon space
                          ],
                        ),
                      ),

                      // ✅ Data Rows
                      ...variants.asMap().entries.map((entry) {
                        int i = entry.key;
                        var row = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              // Attribute Cell (Value)
                              SizedBox(
                                width: 90,
                                child: MyTextField(
                                  hint: 'M',
                                  marginBottom: 0,
                                  contentvPad: 8,
                                  iscenter: true,
                                  onChanged: (v) => row['attribute'] = v,
                                  // In a real app, use a controller or handle state better
                                  // For now, updating map directly as it's a small list
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Price
                              SizedBox(
                                width: 80,
                                child: MyTextField(
                                  hint: '25.99',
                                  marginBottom: 0,
                                  contentvPad: 8,
                                  iscenter: true,
                                  onChanged: (v) => row['price'] = v,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Available
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    row['available'] = row['available'] == 'Yes'
                                        ? 'No'
                                        : 'Yes';
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color:
                                        getAvailabilityColor(row['available']),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: MyText(
                                      text: row['available'],
                                      color: kblack,
                                      size: 10),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // On Hand
                              SizedBox(
                                width: 60,
                                child: MyTextField(
                                  hint: '100',
                                  marginBottom: 0,
                                  contentvPad: 8,
                                  iscenter: true,
                                  onChanged: (v) => row['onHand'] = v,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // SKU
                              SizedBox(
                                width: 100,
                                child: MyTextField(
                                  hint: 'SKU-001',
                                  marginBottom: 0,
                                  contentvPad: 8,
                                  iscenter: true,
                                  onChanged: (v) => row['sku'] = v,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: kred, size: 20),
                                onPressed: () {
                                  setState(() {
                                    variants.removeAt(i);
                                  });
                                },
                              )
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
                  onTap: _addVariant,
                ),
                MyButton(
                  buttonText: 'Save variant',
                  mBottom: 30,
                  onTap: () {
                    Get.back(result: {
                      'name': nameCtrl.text.trim(),
                      'variants': variants,
                    });
                  },
                )
              ],
            ))));
  }
}
