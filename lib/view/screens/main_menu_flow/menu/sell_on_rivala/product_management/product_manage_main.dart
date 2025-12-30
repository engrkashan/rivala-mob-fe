import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/edit_existing_products.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/import_products.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

import '../../../../../widgets/bounce_widget.dart';
import '../../../../../widgets/button_container.dart';
import '../../../../../widgets/common_image_view_widget.dart';
import '../../../../../widgets/custome_comtainer.dart';
import '../../../../../widgets/main_menu_widgets/commission_widgets.dart';
import '../../../../../widgets/my_text_widget.dart';

class ProductManageMain extends StatefulWidget {
  const ProductManageMain({super.key});

  @override
  State<ProductManageMain> createState() => _ProductManageMainState();
}

class _ProductManageMainState extends State<ProductManageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context, title: 'Product Management', centerTitle: true),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        row_widget(
                          onTap: () {
                            Navigator.of(context).push(
                              CustomPageRoute(page: EditExistingProducts()),
                            );
                          },
                          icon: Assets.imagesAdd3,
                          title: ' Add new link',
                          iconSize: 22,
                          texSize: 12,
                          weight: FontWeight.bold,
                        ),
                        row_widget(
                          onTap: () {
                            Get.to(() => ImportProducts());
                          },
                          icon: Assets.imagesUpload2,
                          title: ' Import from LinkTree',
                          iconSize: 22,
                          texSize: 12,
                          weight: FontWeight.bold,
                          textColor: kblack,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: MyTextField(
                      hint: 'Search SKUs',
                      prefixIcon: Image.asset(
                        Assets.imagesSearch,
                        width: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: product_manage_container(),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class product_manage_container extends StatefulWidget {
  final String? title, desc;
  const product_manage_container({super.key, this.title, this.desc});

  @override
  State<product_manage_container> createState() =>
      _product_manage_containerState();
}

class _product_manage_containerState extends State<product_manage_container> {
  bool isActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .loadCurrentProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, product, _) {
      final prd = product.prds;
      if (product.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (prd == null || prd.isEmpty) {
        return Center(
          child: MyText(text: "No products Found"),
        );
      }

      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: prd.length,
          itemBuilder: (context, index) {
            final p = prd[index];
            return CustomeContainer(
              radius: 15,
              hasShadow: true,
              color: kwhite,
              vpad: 12,
              hpad: 12,
              mbott: 10,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(p.image?.length ?? 0, (i) {
                        return CommonImageView(
                          imagePath: Assets.imagesNutrition2,
                          url: p.image?[i],
                          radius: 8,
                          width: 54,
                          height: 54,
                        );
                      }),
                      Bounce_widget(
                          ontap: () {
                            setState(() {
                              isActive = !isActive;
                            });
                          },
                          widget: Icon(
                            isActive
                                ? Icons.keyboard_arrow_down_rounded
                                : Icons.keyboard_arrow_right_rounded,
                            color: kblack,
                          ))
                    ],
                  ),
                  MyText(
                    text: p.title ?? 'Message Playbook',
                    size: 15,
                    color: kblack,
                    paddingTop: 15,
                    weight: FontWeight.w500,
                    paddingBottom: 15,
                  ),
                  // texts_row(
                  //   text1: 'TYPE: ',
                  //   text2: p.,
                  // ),
                  // texts_row(
                  //   text1: 'STATUS:',
                  //   text2: p.s,
                  //   color2: kgreen2,
                  // ),
                  texts_row(
                    text1: 'SKU:',
                    text2: p.SKU,
                  ),
                  texts_row(
                    text1: 'COMMISSION: ',
                    text2: p.price.toString(),
                  ),
                  if (isActive) ...{
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        buttonContainer(
                          text: 'Make Unavailable',
                          bgColor: korange,
                          radius: 5,
                          vPadding: 4,
                          textsize: 10,
                          hPadding: 3,
                          txtColor: kblack,
                          weight: FontWeight.normal,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        buttonContainer(
                          text: 'Delete Product',
                          bgColor: kred,
                          radius: 5,
                          vPadding: 4,
                          textsize: 10,
                          hPadding: 3,
                          txtColor: kblack,
                          weight: FontWeight.normal,
                        ),
                      ],
                    ),
                    MyText(
                      text: '> Edit product',
                      size: 12,
                      weight: FontWeight.w500,
                      color: kblue,
                      paddingTop: 15,
                      onTap: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                              page: EditExistingProducts(
                            product: p,
                          )),
                        );
                      },
                    )
                  },
                ],
              ),
            );
          });
    });
  }
}
