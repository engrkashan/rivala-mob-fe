import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/fulfillment.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class ManualFulfillment extends StatefulWidget {
  const ManualFulfillment({super.key});

  @override
  State<ManualFulfillment> createState() => _ManualFulfillmentState();
}

class _ManualFulfillmentState extends State<ManualFulfillment> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController keyCtrl = TextEditingController();
  final TextEditingController secretCtrl = TextEditingController();
  String selectedType = 'SHIP_STATION';

  Future<void> _handleVerify() async {
    final name = nameCtrl.text.trim();
    final key = keyCtrl.text.trim();
    final secret = secretCtrl.text.trim();

    if (name.isEmpty || key.isEmpty || secret.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    final provider = context.read<fulfillmentPro>();
    final success =
        await provider.createProvider(selectedType, name, key, secret);

    if (success) {
      Get.back();
      Get.snackbar("Success", "Fulfillment provider verified and added");
    } else {
      Get.snackbar("Error", "Failed to verify: ${provider.error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context,
          title: 'New fulfillment provider',
          centerTitle: true,
          size: 16),
      body: Consumer<fulfillmentPro>(builder: (context, provider, _) {
        // Ideally show loading overlay if provider.isLoading
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: kgrey2,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  CustomDropDown(
                    hint: 'SHIP_STATION',
                    items: [
                      'SHIP_STATION',
                      'UPS_GROUND',
                      'UPS_NEXT_DAY',
                      'USPS',
                      'AMAZON_FBA',
                      'FBA_AMAZON',
                      'DISCOUNT_SHOPPING',
                      'DISCOUNT_ORDER',
                      'STORE_CREDIT'
                    ],
                    selectedValue: selectedType,
                    onChanged: (s) {
                      setState(() {
                        selectedType = s ?? 'SHIP_STATION';
                      });
                    },
                    label: 'Fulfillment Type',
                    bgColor: ktransparent,
                    bordercolor: kgrey3,
                    radius: 8,
                    vpad: 11,
                    hintsize: 14,
                  ),
                  MyTextField(
                    controller: nameCtrl,
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
                    controller: keyCtrl,
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
                    controller: secretCtrl,
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
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Mybutton2(
        buttonText: 'Verify',
        hpad: 22,
        mbot: 60,
        ontap: _handleVerify,
      ),
    );
  }
}
