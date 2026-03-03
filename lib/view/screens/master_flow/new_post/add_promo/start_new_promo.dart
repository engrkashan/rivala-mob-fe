import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/promo_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/promotions_model.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_dropdown.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import 'add_criteria.dart';

class StartNewPromo extends StatefulWidget {
  final Color? color;
  final String? buttonText;
  final PromotionModel? promo;
  const StartNewPromo({super.key, this.color, this.buttonText, this.promo});

  @override
  State<StartNewPromo> createState() => _StartNewPromoState();
}

class _StartNewPromoState extends State<StartNewPromo> {
  int selectedIndex = 1; // 0 for Creators, 1 for Sellers

  final title = TextEditingController();
  final description = TextEditingController();
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  String status = "Live";
  double discount = 0;
  String promo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context,
          title: 'Start New Promo',
          centerTitle: true,
          actions: [
            Bounce_widget(
              widget: Image.asset(
                Assets.imagesClose,
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(width: 12),
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                MyText(
                  text: 'Who’s this promo for?',
                  size: 17,
                  weight: FontWeight.w500,
                  paddingBottom: 15,
                  color: kblack,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                /// **Row with Equal Size Containers**
                Row(
                  children: [
                    Expanded(
                      child: Bounce_widget(
                        ontap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        widget: CustomeContainer(
                          borderColor: selectedIndex == 0
                              ? ktransparent
                              : widget.color ?? kgreen,
                          color: selectedIndex == 0
                              ? widget.color ?? kblue
                              : ktransparent,
                          radius: 15,
                          widget: Column(
                            children: [
                              Image.asset(
                                Assets.imagesCreator,
                                height: 37,
                                width: 35,
                                color: selectedIndex == 0 ? kwhite : kblack,
                              ),
                              MyText(
                                text: 'CREATORS',
                                size: 18,
                                weight: FontWeight.bold,
                                color: selectedIndex == 0 ? kwhite : kblack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Bounce_widget(
                        ontap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        widget: CustomeContainer(
                          borderColor: selectedIndex == 1
                              ? ktransparent
                              : widget.color ?? kgreen,
                          color: selectedIndex == 1
                              ? widget.color ?? kblue
                              : ktransparent,
                          radius: 15,
                          widget: Column(
                            children: [
                              Image.asset(
                                Assets.imagesSeller,
                                height: 37,
                                width: 35,
                                color: selectedIndex == 1 ? kwhite : kblack,
                              ),
                              MyText(
                                text: 'SELLERS',
                                size: 18,
                                weight: FontWeight.bold,
                                color: selectedIndex == 1 ? kwhite : kblack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 34),
                MyTextField(
                  controller: title,
                  hint: 'Black Friday',
                  label: 'Promo Name',
                  suffixIcon: Image.asset(
                    Assets.imagesEdit,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  delay: 200,
                  filledColor: kblack.withOpacity(0.05),
                  bordercolor: ktransparent,
                ),
                MyTextField(
                  controller: description,
                  hint: 'Promo Description',
                  label: 'Description',
                  suffixIcon: Image.asset(
                    Assets.imagesEdit,
                    width: 20,
                    height: 20,
                  ),
                  maxLines: 4,
                  delay: 400,
                  filledColor: kblack.withOpacity(0.05),
                  bordercolor: ktransparent,
                ),
                MyTextField(
                  controller: startDate,
                  hint: 'MM/DD/YYYY',
                  label: 'Start Date',
                  filledColor: kblack.withOpacity(0.05),
                  bordercolor: ktransparent,
                  readOnly: true, // 👈 IMPORTANT
                  ontapp: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      startDate.text =
                          '${pickedDate.month}/${pickedDate.day}/${pickedDate.year}';
                    }
                  },
                  suffixIcon: Image.asset(
                    Assets.imagesCalender,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  delay: 600,
                ),

                MyTextField(
                  controller: endDate,
                  hint: 'MM/DD/YYYY',
                  label: 'End Date',
                  filledColor: kblack.withOpacity(0.05),
                  suffixIcon: Image.asset(
                    Assets.imagesCalender,
                    width: 20,
                    height: 20,
                  ),
                  ontapp: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      endDate.text =
                          '${pickedDate.month}/${pickedDate.day}/${pickedDate.year}';
                    }
                  },
                  readOnly: true,
                  delay: 800,
                  bordercolor: ktransparent,
                ),
                CustomDropDown(
                  delay: 1000,
                  label: 'Status',
                  hint: 'Live',
                  items: ['Off', 'Paused', 'Live'],
                  selectedValue: status,
                  onChanged: (e) {
                    status = e;
                    setState(() {});
                  },
                ),

                // Display Targets
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: context.watch<PromoProvider>().targetList.length,
                    itemBuilder: (context, i) {
                      final target =
                          context.watch<PromoProvider>().targetList[i];
                      final type = target.targetType ?? "PRODUCT";
                      final id = target.productId ?? target.collectionId ?? "";

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: 'Target #${i + 1}',
                            size: 15,
                            weight: FontWeight.w500,
                            color: kblack,
                            paddingBottom: 15,
                          ),
                          CustomeContainer(
                            radius: 15,
                            vpad: 10,
                            hpad: 12,
                            color: kblack.withOpacity(0.05),
                            mbott: 20,
                            widget: Row(
                              children: [
                                Image.asset(
                                  type == "PRODUCT"
                                      ? Assets.imagesProduct
                                      : Assets.imagesCollection,
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: MyText(
                                    text: 'Specific $type promo (ID: $id)',
                                    size: 14,
                                    color: ktertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),

                // Display Criteria
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        context.watch<PromoProvider>().criteriaList.length,
                    itemBuilder: (context, i) {
                      final criteria =
                          context.watch<PromoProvider>().criteriaList[i];
                      final cond = criteria.condition ?? "";
                      final action = criteria.action ?? "";

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: 'Criteria #${i + 1}',
                            size: 15,
                            weight: FontWeight.w500,
                            color: kblack,
                            paddingBottom: 15,
                          ),
                          Container(
                            height: Get.height * 0.15, // Adjusted height
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Row(
                                  children: [
                                    MyText(
                                      text: 'IF',
                                      color: kblack,
                                      weight: FontWeight.w700,
                                      size: 20,
                                      paddingRight: 5,
                                    ),
                                    Image.asset(
                                      Assets.imagesIfIcon,
                                      width: 34,
                                      height: 34,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: CustomeContainer(
                                        radius: 15,
                                        vpad: 10,
                                        hpad: 12,
                                        color: kblack.withOpacity(0.05),
                                        widget: MyText(
                                          text: cond,
                                          size: 14,
                                          color: ktertiary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  top: 50,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: 'THEN',
                                        color: kblack,
                                        weight: FontWeight.w700,
                                        size: 10,
                                        paddingRight: 5,
                                      ),
                                      Image.asset(
                                        Assets.imagesThen,
                                        width: 34,
                                        height: 34,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: CustomeContainer(
                                          radius: 15,
                                          vpad: 10,
                                          hpad: 12,
                                          color: kblack.withOpacity(0.05),
                                          widget: MyText(
                                            text: action,
                                            size: 14,
                                            color: ktertiary,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),

                MyText(
                  text: '+ Add criteria',
                  size: 12,
                  color: kblue,
                  onTap: () {
                    Get.bottomSheet(AddCriteria(), isScrollControlled: true);
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Consumer<PromoProvider>(builder: (context, ref, _) {
            return ref.isLoading
                ? const Center(child: CircularProgressIndicator())
                : MyButton(
                    buttonText: widget.buttonText ?? 'Add & save promo',
                    mBottom: 30,
                    mhoriz: 22,
                    onTap: () async {
                      await context.read<PromoProvider>().uploadPromo(
                            id: widget.promo?.id, // Added id
                            title: title.text,
                            description: description.text,
                            startDate: startDate.text,
                            endDate: endDate.text,
                            status: status,
                            promo: promo,
                            discount: discount,
                            targetAudience:
                                selectedIndex == 0 ? "CREATORS" : "SELLERS",
                          );
                      Get.back();
                    },
                  );
          })
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<PromoProvider>();
      if (widget.promo != null) {
        provider
            .setDataFromPromo(widget.promo); // Populate criteria and targets
        title.text = widget.promo?.title ?? "";
        description.text = widget.promo?.description ?? "";
        startDate.text =
            "${widget.promo?.startDate?.month}/${widget.promo?.startDate?.day}/${widget.promo?.startDate?.year}";
        endDate.text =
            "${widget.promo?.endDate?.month}/${widget.promo?.endDate?.day}/${widget.promo?.endDate?.year}";
        status = widget.promo?.status == "ACTIVE"
            ? "Live"
            : widget.promo?.status == "INACTIVE"
                ? "Off"
                : widget.promo?.status ?? "Live";
        discount = widget.promo?.discount ?? 0;
        promo = widget.promo?.promoCode ?? "";
        selectedIndex = widget.promo?.targetAudience == "CREATORS" ? 0 : 1;
      } else {
        provider.clearData(); // Clear only for new promo
      }
    });
  }
}
