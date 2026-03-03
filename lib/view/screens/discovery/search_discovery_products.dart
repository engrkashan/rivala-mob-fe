import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_tags.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/main_profile.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class SearchDiscoveryProducts extends StatefulWidget {
  const SearchDiscoveryProducts({super.key});

  @override
  State<SearchDiscoveryProducts> createState() =>
      _SearchDiscoveryProductsState();
}

class _SearchDiscoveryProductsState extends State<SearchDiscoveryProducts> {
  final searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  Assets.imagesRivalalogo,
                  height: 33,
                  width: 148,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: searchCon,
                    hint: 'Swim suit',
                    bordercolor: kgrey2,
                    filledColor: ktransparent,
                    contentvPad: 6.5,
                    radius: 45,
                    prefixIcon: Image.asset(
                      Assets.imagesSearch,
                      width: 15,
                    ),
                    // readOnly: true,
                    onChanged: (e) {
                      context.read<ProductProvider>().onSearchChanged(e);
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<BrandsProvider>(
                    builder: (context, ref, _) {
                      return row_widget(
                          // icon: ref.currentStor,
                          icon: ref.currentStore?.logoUrl,
                          title: ref.currentStore?.name,
                          iconSize: 54,
                          texSize: 15,
                          onTap: () {
                            Get.to(() => StoreMainProfile());
                          });
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (searchCon.text.isNotEmpty)
                    Consumer<ProductProvider>(
                      builder: (context, ref, _) {
                        print("prd length: ${ref.searchProductsList?.length}");
                        final prds = ref.searchProductsList;
                        return ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: prds?.length ?? 0,
                          itemBuilder: (context, switchIndex) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: tags_search_row(
                                  size: 54,
                                  hpad: 0,
                                  bgColor: ktransparent,
                                  product: prds![switchIndex],
                                  isProduct: true,
                                  onlyTexts: true,
                                ));
                          },
                        );
                      },
                    )
                ],
              ),
            ),
          ],
        ));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<ProductProvider>().loadAllProducts();
  //   });
  // }
}
