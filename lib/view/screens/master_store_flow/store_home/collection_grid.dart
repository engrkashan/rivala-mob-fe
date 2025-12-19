import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/add_filters.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/fotter.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/providers/brands_provider.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/product_detailed_description.dart';

class CollectionGrid extends StatefulWidget {
  final String? text1, text2;
  const CollectionGrid({super.key, this.text1, this.text2});

  @override
  State<CollectionGrid> createState() => _CollectionGridState();
}

class _CollectionGridState extends State<CollectionGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderImageStack(
              showContent: false,
            ),
//

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: TwoTextedColumn(
                text1: widget.text1 ?? 'New Arrivals',
                text2: widget.text2 ??
                    'Discover our vibrant, eco-friendly swimwear collection, inspired by Bondi Beach. ',
                color1: kheader,
                color2: kbody,
                weight1: FontWeight.w600,
                size1: 18,
                size2: 14,
                useCustomFont: true,
              ),
            ),

            // Align(
            //     alignment: Alignment.topRight,
            //     child: MyText(
            //       text: '+ Filters',
            //       size: 13,
            //       weight: FontWeight.w600,
            //       textAlign: TextAlign.end,
            //       paddingRight: 22,
            //       paddingBottom: 20,
            //        useCustomFont: true,
            //       onTap: (){
            //         Get.dialog(AddFiltersDialog());
            //       },
            //     )),
            Consumer<BrandsProvider>(builder: (context, store, _) {
              if (store.currentStore?.products == null ||
                  store.currentStore!.products.isEmpty) {
                return Text("No products found");
              }
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    mainAxisExtent: 155),
                itemCount: store.currentStore?.products.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => Get.to(() => ProductDetailedDescription(
                            product: store.currentStore!.products[index],
                          )),
                      child: store_image_stack(
                          height: 150,
                          showContent: false,
                          iconSize: 22,
                          showShadow: false,
                          url: store.currentStore?.products[index].image?[0]));
                },
              );
            }),
            SizedBox(
              height: 30,
            ),
            StoreFotter()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
        child: Store_Button_Row(),
      ),
    );
  }
}
