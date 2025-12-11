import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/product_management/edit_existing_products.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/start_new_promo.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/main_menu_widgets/commission_widgets.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../../controllers/providers/promo_provider.dart';
import '../../../../../../models/promotions_model.dart';

class PromotionsMain extends StatefulWidget {
  const PromotionsMain({super.key});

  @override
  State<PromotionsMain> createState() => _PromotionsMainState();
}

class _PromotionsMainState extends State<PromotionsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context, title: 'Promotions', centerTitle: true),
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
                    child: row_widget(
                      onTap: () {
                        Get.to(() => StartNewPromo(
                              buttonText: 'Save Promo',
                            ));
                      },
                      icon: Assets.imagesAdd3,
                      title: ' Start new promo',
                      iconSize: 22,
                      texSize: 12,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Consumer<PromoProvider>(builder: (context, ref, _) {
                    if (ref.promos.isEmpty) {
                      return Center(
                        child: MyText(
                          text: "No promos available",
                        ),
                      );
                    }
                    final promo = ref.promos;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: promo.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: promotions_container(
                            promo: promo[index],
                          ),
                        );
                      },
                    );
                  }),
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

class promotions_container extends StatefulWidget {
  final String? title, desc;
  final PromotionModel? promo;
  const promotions_container({super.key, this.title, this.desc, this.promo});

  @override
  State<promotions_container> createState() => _promotions_containerState();
}

class _promotions_containerState extends State<promotions_container> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final promo = widget.promo;
    return CustomeContainer(
      radius: 15,
      hasShadow: true,
      color: kwhite,
      vpad: 12,
      hpad: 12,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: promo?.title ?? 'Message Playbook',
                size: 15,
                color: kblack,
                paddingTop: 15,
                weight: FontWeight.w500,
                paddingBottom: 15,
              ),
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
          TwoTextedColumn(
            text1: 'Description:',
            text2: promo?.description ?? "",
            weight1: FontWeight.w500,
            weight2: FontWeight.normal,
            size1: 10,
            size2: 10,
          ),
          SizedBox(
            height: 15,
          ),
          texts_row(
            text1: 'Start Date:',
            text2:
                '${promo?.startDate?.month}, ${promo?.startDate?.day}, ${promo?.startDate?.year}',
          ),
          texts_row(
            text1: 'End Date:',
            text2:
                '${promo?.endDate?.month}, ${promo?.endDate?.day}, ${promo?.endDate?.year}',
          ),
          texts_row(
            text1: 'STATUS:',
            text2: promo?.status ?? "In Progress",
            color2: ktertiary,
          ),
          if (isActive) ...{
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                buttonContainer(
                  text: 'Pause Promo',
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
              text: '> Edit promo',
              size: 12,
              weight: FontWeight.w500,
              color: kblue,
              paddingTop: 15,
              onTap: () {
                Get.to(() => EditExistingProducts());
              },
            )
          }
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PromoProvider>().setPromos();
    });
  }
}
