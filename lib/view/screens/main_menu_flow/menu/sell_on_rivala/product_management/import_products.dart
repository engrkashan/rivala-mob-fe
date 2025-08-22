import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/import_csv.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class ImportProducts extends StatefulWidget {
  const ImportProducts({super.key});

  @override
  State<ImportProducts> createState() => _ImportProductsState();
}

class _ImportProductsState extends State<ImportProducts> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,
          title: 'Import Products',
          centerTitle: true
        ),
        body: Column(
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
                    hint: 'Enter URL',
                    label: 'Import from Shopify',
                    bordercolor: kgrey2,
                    filledColor: ktransparent,
                  ),
                    MyTextField(
                      delay: 200,
                    hint: 'Enter URL',
                    label: 'Import from Etsy',
                    bordercolor: kgrey2,
                    filledColor: ktransparent,
                  ),
                  SizedBox(height: 15,),
                    row_widget(
                          onTap: () {
                             Get.to(() => ImportCsv());
                          },
                          icon: Assets.imagesUpload2,
                          iconColor: kblue,
                          title: ' Import CSV',
                          iconSize: 22,
                          texSize: 12,
                          weight: FontWeight.w500,
                          textColor: kblue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8,bottom: 8,right: 150),
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
        ),
        
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:     MyButton(
          onTap: () {
             Get.to(() => ImportCsv());
          },
              buttonText: 'Import links',
              mhoriz: 22,
              mBottom: 50,
            ),)
        
        ;
  }
}

