import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/promo_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/promotions_model.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class PromoCode extends StatefulWidget {
  final String? title;
  final bool? isPromo, isMinMax;
  final String? targetType; // NEW: "PRODUCT" or "COLLECTION"

  const PromoCode({
    super.key,
    this.title,
    this.isPromo = false,
    this.isMinMax = false,
    this.targetType,
  });

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  final TextEditingController minController = TextEditingController();
  String selectedType = "Discount entire order";
  final TextEditingController maxController = TextEditingController();
  final TextEditingController promoController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  String? selectedId; // NEW
  String? selectedName; // NEW

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: kwhite),
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bounce_widget(
                  ontap: () {
                    Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesBackicon1,
                    width: 22,
                    height: 22,
                  )),
              MyText(
                text: widget.title ?? 'Promo Code',
                size: 15,
                weight: FontWeight.w500,
              ),
              Bounce_widget(
                  ontap: () {
                    Get.back();
                  },
                  widget: Image.asset(
                    Assets.imagesClose2,
                    width: 22,
                    height: 22,
                  ))
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          if (widget.targetType != null) ...{
            MyTextField(
              hint: selectedName ??
                  'Search ${widget.targetType == "PRODUCT" ? "Products" : "Collections"}',
              prefixIcon: Image.asset(
                Assets.imagesSearch,
                width: 15,
                height: 15,
              ),
              readOnly: true,
              ontapp: () {
                Get.bottomSheet(
                    SearchCriteriaProducts(
                      title: widget.targetType == "PRODUCT"
                          ? "Search Products"
                          : "Search Collections",
                      hintText: widget.targetType == "PRODUCT"
                          ? "Enter product name"
                          : "Enter collection name",
                      onItemSelected: (item) {
                        setState(() {
                          selectedId = item.id;
                          selectedName = item.title ?? item.name;
                        });
                        Get.back();
                      },
                    ),
                    isScrollControlled: true);
              },
              contentvPad: 6,
            ),
          },
          ////if minmax

          if (widget.isMinMax == true) ...{
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MyText(
                    text: 'Minimum Purchase',
                    size: 12,
                    paddingRight: 8,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: MyTextField(
                    radius: 50,
                    marginBottom: 0,
                    hint: '\$100',
                    contentvPad: 4,
                    controller: minController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MyText(
                    text: 'Maximum Purchase',
                    size: 12,
                    paddingRight: 8,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: MyTextField(
                    radius: 50,
                    marginBottom: 0,
                    hint: '\$100',
                    contentvPad: 4,
                    controller: maxController,
                  ),
                ),
              ],
            ),
          },

          ////if promo
          if (widget.isPromo == true) ...{
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                MyText(
                  text: 'Set Code',
                  size: 12,
                  paddingRight: 8,
                ),
                Expanded(
                  child: MyTextField(
                    radius: 50,
                    marginBottom: 0,
                    hint: 'Enter Promo Code',
                    contentvPad: 4,
                    controller: promoController,
                  ),
                ),
              ],
            ),
          },

          Row(
            children: [
              Expanded(
                flex: 1,
                child: MyText(
                  text: 'Discount Type',
                  size: 12,
                  paddingRight: 8,
                  paddingTop: 4,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: CustomDropDown(
                      vpad: 4,
                      iconPad: 2,
                      bgColor: ktransparent,
                      bordercolor: ktertiary,
                      hint: 'Choose your discount type',
                      items: const [
                        'Discount shipping',
                        'Discount entire order'
                      ],
                      selectedValue: selectedType,
                      onChanged: (e) {
                        selectedType = e!;
                        setState(() {});
                      })),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MyText(
                  text: 'Discount Amount',
                  size: 11,
                  paddingRight: 8,
                ),
              ),
              Expanded(
                flex: 3,
                child: MyTextField(
                  radius: 50,
                  marginBottom: 0,
                  hint: '10%',
                  contentvPad: 4,
                  controller: discountController,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: CustomeContainer(
                  vpad: 2,
                  hpad: 3,
                  color: kblack.withOpacity(0.05),
                  widget: Row(
                    children: [
                      const Bounce_widget(
                        widget: Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Icon(
                            Icons.minimize_rounded,
                            color: kblack,
                            size: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomeContainer(
                          color: kwhite,
                          vpad: 4,
                          hpad: 2,
                          radius: 4,
                          widget: MyText(
                            text: '70%',
                            size: 8,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Bounce_widget(
                          widget: Icon(
                        Icons.add_rounded,
                        color: kblack,
                        size: 14,
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          MyButton(
            buttonText: 'Save criteria',
            onTap: () {
              final provider =
                  Provider.of<PromoProvider>(context, listen: false);

              if (widget.targetType != null && selectedId != null) {
                // Handle Target
                provider.addTarget(PromotionTargetModel(
                  targetType: widget.targetType,
                  productId: widget.targetType == "PRODUCT" ? selectedId : null,
                  collectionId:
                      widget.targetType == "COLLECTION" ? selectedId : null,
                ));
              }

              if (widget.isMinMax == true ||
                  (widget.isPromo == true && promoController.text.isNotEmpty)) {
                // Handle Criteria
                String condition = "";
                if (widget.isMinMax == true) {
                  condition =
                      "Min: \$${minController.text}, Max: \$${maxController.text}";
                } else {
                  condition = "Code: ${promoController.text}";
                }

                provider.addCriteria(PromotionCriteriaModel(
                  condition: condition,
                  action: "$selectedType ${discountController.text}%",
                ));
              }

              Get.back();
            },
            mBottom: 60,
          )
        ]));
  }
}
