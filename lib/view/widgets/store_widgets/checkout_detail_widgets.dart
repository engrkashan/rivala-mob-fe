import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/cart_provider.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/choose_existing_cards.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/ordering/order_confirmation.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

import '../../../controllers/providers/payment_methods_provider.dart';
import '../../../generated/assets.dart';

class order_summary_container extends StatelessWidget {
  final bool? placeOrder;
  const order_summary_container({
    super.key,
    this.placeOrder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(color: kgrey2)),
        color: kgrey2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // bag_items_row(showAmount: true, size: 80),
          if (placeOrder == false) ...{
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    radius: 8,
                    contentvPad: 3,
                    useCustomFont: true,
                    hint: 'Discount code or gift card',
                    filledColor: ktransparent,
                    marginBottom: 0,
                  ),
                ),
                const SizedBox(width: 8),
                buttonContainer(
                  text: 'APPLY',
                  useCustomFont: true,
                  radius: 8,
                  vPadding: 3,
                  txtColor: kdargrey,
                  bgColor: kblack.withOpacity(0.05),
                )
              ],
            ),
          },
          const SizedBox(height: 30),
          ExpandedRow(
            text1: 'Subtotal (1)',
            text2: '\$199.99',
            color1: kdargrey,
            color2: kdarkgrey,
            size1: 16,
            size2: 16,
            weight1: FontWeight.normal,
            weight2: FontWeight.normal,
            useCustomFont: true,
          ),
          ExpandedRow(
            text1: 'Estimated Tax',
            text2: '\$14.00',
            color1: kdargrey,
            color2: kdarkgrey,
            size1: 16,
            size2: 16,
            weight1: FontWeight.normal,
            weight2: FontWeight.normal,
            useCustomFont: true,
          ),
          ExpandedRow(
            text1: 'Promo code',
            text2: '\$17.00',
            color1: kdargrey,
            color2: kdarkgrey,
            size1: 16,
            size2: 16,
            weight1: FontWeight.normal,
            weight2: FontWeight.normal,
            useCustomFont: true,
          ),
          const SizedBox(height: 20),
          ExpandedRow(
            text1: 'Total',
            text2: '\$213.00',
            color1: kblack2,
            color2: kblack2,
            size1: 16,
            size2: 16,
            weight1: FontWeight.w600,
            weight2: FontWeight.w600,
            useCustomFont: true,
          ),
          const SizedBox(height: 30),

          if (placeOrder == true)
            Mybutton2(
              buttonText: 'Place order',
              useCustomFont: true,
              ontap: () {
                Get.to(() => OrderConfirmation());
              },
            )
        ],
      ),
    );
  }
}

/////////////////////

class shipping_opt_container extends StatelessWidget {
  final bool? isFree, singleText, isActive;
  final String? date, deliveryText, title;
  final Color? border;
  const shipping_opt_container({
    super.key,
    this.isFree,
    this.date,
    this.deliveryText,
    this.singleText = false,
    this.title,
    this.border,
    this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      color: kwhite,
      borderColor: border ?? ktransparent,
      vpad: 8,
      hpad: 8,
      radius: 8,
      widget: Row(
        children: [
          Expanded(
              child: singleText == false
                  ? TwoTextedColumn(
                      text1: date ?? 'Monday, Sep 23',
                      text2: isFree == false
                          ? deliveryText ?? '\$6.99 delivery'
                          : 'FREE delivery',
                      mBottom: 2,
                      size2: 12,
                      size1: 13,
                      color1: kheader,
                      color2: isFree == true ? kgreen : kheader,
                      weight1: FontWeight.w500,
                      useCustomFont: true,
                    )
                  : MyText(
                      text: title ?? 'Credit Card',
                      color: kdargrey,
                      size: 14,
                      useCustomFont: true,
                    )),
          CustomCheckBox(
            isActive: isActive ?? false,
            onTap: () {},
            iscircle: true,
            selectedColor: kwhite,
            unSelectedColor: ktransparent,
            bordercolor2: kblack,
            borderColor: kblack,
            iconColor: kblack,
          )
        ],
      ),
    );
  }
}

///shipping metod list

class shipping_method_list extends StatelessWidget {
  final RxBool showShippingMethod;
  const shipping_method_list({super.key, required this.showShippingMethod});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Bounce_widget(
            ontap: () {
              showShippingMethod.value = !showShippingMethod.value;
            },
            widget: CustomeContainer(
              vpad: 8,
              hpad: 8,
              borderColor: kgrey2,
              color: kwhite,
              radius: 8,
              widget: Row(
                children: [
                  store_image_stack(
                    height: 36,
                    width: 36,
                    showIcon: false,
                    showShadow: false,
                    showContent: false,
                    iconSize: 20,
                    radius: 8,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TwoTextedColumn(
                    text1: 'Blue Floral Short',
                    text2: 'Monday, Sep. 23',
                    mBottom: 2,
                    size2: 12,
                    size1: 13,
                    weight1: FontWeight.w600,
                    useCustomFont: true,
                  )),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: kblack2,
                  )
                ],
              ),
            ),
          ),
          if (showShippingMethod.value) ...{
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, Index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: shipping_opt_container(
                      isFree: Index == 0 ? true : false,
                    ),
                  );
                },
              ),
            )
          }
        ],
      ),
    );
  }
}

///payment

class payment_method_list extends StatefulWidget {
  final String? title;
  final RxBool showPaymentMethod;
  payment_method_list({super.key, required this.showPaymentMethod, this.title});

  @override
  State<payment_method_list> createState() => _payment_method_listState();
}

class _payment_method_listState extends State<payment_method_list> {
  final _cardFormKey = GlobalKey<FormState>();

  bool isVisa(String input) {
    return RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$').hasMatch(input);
  }

  bool isMasterCard(String input) {
    return RegExp(
      r'^(5[1-5][0-9]{14}|2(2[2-9][0-9]{12}|[3-6][0-9]{13}|7[01][0-9]{12}|720[0-9]{12}))$',
    ).hasMatch(input);
  }

  bool luhnCheck(String cardNumber) {
    int sum = 0;
    bool alternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cardNumber[i]);

      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }

      sum += n;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  String? cardNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Card number is required';
    }

    final number = value.replaceAll(' ', '');

    if (!(isVisa(number) || isMasterCard(number))) {
      return 'Only Visa or MasterCard allowed';
    }

    if (!luhnCheck(number)) {
      return 'Invalid card number';
    }

    return null;
  }

  String? cvcValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVC is required';
    }

    if (!RegExp(r'^[0-9]{3,4}$').hasMatch(value)) {
      return 'Invalid CVC';
    }

    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name on card is required';
    }

    if (value.trim().length < 3) {
      return 'Enter full name';
    }

    return null;
  }

  bool showAddNewCardForm = false;

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.read<PaymentMethodsProvider>();

    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        final selectedCard = cartProvider.selectedCard;
        final hasSelectedCard = selectedCard != null &&
            selectedCard.isNotEmpty &&
            !showAddNewCardForm;

        String? cardBrand;
        String? cardImage;

        if (hasSelectedCard) {
          cardBrand = paymentProvider.detectCardBrand(selectedCard);
          cardImage = cardBrand == 'mastercard'
              ? Assets.imagesMastercard
              : Assets.imagesVisa;
        }

        return Form(
          key: _cardFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---- HEADER (Rx ONLY HERE) ----
              Obx(() {
                return Bounce_widget(
                  ontap: () {
                    widget.showPaymentMethod.value =
                        !widget.showPaymentMethod.value;
                  },
                  widget: shipping_opt_container(
                    title: widget.title,
                    border: ktertiary.withOpacity(0.6),
                    singleText: true,
                    isActive: widget.showPaymentMethod.value,
                  ),
                );
              }),

              /// ---- BODY (PROVIDER) ----
              Obx(() {
                if (!widget.showPaymentMethod.value) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    MyText(
                      text: hasSelectedCard
                          ? '> Select another card'
                          : '> Use pre-existing card',
                      color: kblue,
                      size: 14,
                      paddingLeft: 18,
                      paddingBottom: 10,
                      useCustomFont: true,
                      onTap: () async {
                        await Get.to(() => ChooseExistingCards());
                      },
                    ),
                    if (hasSelectedCard) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: choose_card(
                          showIsActive: false,
                          img: cardImage!,
                          title:
                              '$cardBrand •••• ${selectedCard!.substring(selectedCard.length - 4)}',
                        ),
                      ),
                      MyText(
                        text: '+ Add new card',
                        onTap: () {
                          setState(() {
                            showAddNewCardForm = true;
                          });
                        },
                      ),
                    ] else ...[
                      _AddCardForm(
                        formKey: _cardFormKey,
                        onSave: (cardNumber, cvc, name) async {
                          await context
                              .read<CartProvider>()
                              .saveCard(cardNumber);

                          setState(() {
                            showAddNewCardForm = false;
                          });
                        },
                        cardNumberValidator: cardNumberValidator,
                        cvcValidator: cvcValidator,
                        nameValidator: nameValidator,
                      ),
                    ],
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _AddCardForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String, String, String) onSave;
  final String? Function(String?) cardNumberValidator;
  final String? Function(String?) cvcValidator;
  final String? Function(String?) nameValidator;

  const _AddCardForm({
    required this.formKey,
    required this.onSave,
    required this.cardNumberValidator,
    required this.cvcValidator,
    required this.nameValidator,
  });

  @override
  Widget build(BuildContext context) {
    final cardNumber = TextEditingController();
    final cvc = TextEditingController();
    final name = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: MyTextField(
            controller: cardNumber,
            hint: 'Card number',
            validator: cardNumberValidator,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: MyTextField(
            controller: cvc,
            hint: 'Security Code',
            validator: cvcValidator,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: MyTextField(
            controller: name,
            hint: 'Name on Card',
            validator: nameValidator,
          ),
        ),
        MyText(
          text: '+ Save card',
          onTap: () {
            if (!formKey.currentState!.validate()) return;
            onSave(
              cardNumber.text.trim(),
              cvc.text.trim(),
              name.text.trim(),
            );
          },
        ),
      ],
    );
  }
}
