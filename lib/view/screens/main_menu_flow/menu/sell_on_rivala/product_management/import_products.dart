import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/import_product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/import_csv.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class ImportProducts extends StatefulWidget {
  const ImportProducts({super.key});

  @override
  State<ImportProducts> createState() => _ImportProductsState();
}

class _ImportProductsState extends State<ImportProducts> {
  final TextEditingController _shopifyController = TextEditingController();
  final TextEditingController _etsyController = TextEditingController();

  @override
  void dispose() {
    _shopifyController.dispose();
    _etsyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context, title: 'Import Products', centerTitle: true),
      body: Consumer<ImportProductProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    MyTextField(
                      controller: _shopifyController,
                      hint: 'Enter URL',
                      label: 'Import from Shopify',
                      bordercolor: kgrey2,
                      filledColor: ktransparent,
                      onChanged: (val) => provider.setShopifyUrl(val),
                    ),
                    MyTextField(
                      controller: _etsyController,
                      delay: 200,
                      hint: 'Enter URL',
                      label: 'Import from Etsy',
                      bordercolor: kgrey2,
                      filledColor: ktransparent,
                      onChanged: (val) => provider.setEtsyUrl(val),
                    ),
                    const SizedBox(height: 15),
                    row_widget(
                      onTap: () {
                        provider.pickCsvFile();
                      },
                      icon: Assets.imagesUpload2,
                      iconColor: kblue,
                      title: ' Import CSV',
                      iconSize: 22,
                      texSize: 12,
                      weight: FontWeight.w500,
                      textColor: kblue,
                    ),
                    if (provider.selectedFileName != null) ...[
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: MyText(
                          text: 'Selected file: ${provider.selectedFileName}',
                          size: 12,
                          color: ktertiary,
                        ),
                      ),
                    ],
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, right: 150),
                      child: Divider(
                        color: kblack.withOpacity(0.4),
                      ),
                    ),
                    row_widget(
                      onTap: () {
                        // Get.to(() => ImportProducts());
                      },
                      icon: Assets.imagesFolder,
                      title: 'fall-2024-sku-NR',
                      iconSize: 22,
                      texSize: 12,
                      weight: FontWeight.w500,
                      textColor: ktertiary,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyButton(
        onTap: () {
          final provider =
              Provider.of<ImportProductProvider>(context, listen: false);
          provider.importProducts();
          Get.to(() => const ImportCsv());
        },
        buttonText: 'Import links',
        mhoriz: 22,
        mBottom: 50,
      ),
    );
  }
}
