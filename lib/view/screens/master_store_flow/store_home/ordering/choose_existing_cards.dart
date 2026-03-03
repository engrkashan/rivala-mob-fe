import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/cart_provider.dart';
import 'package:rivala/controllers/providers/payment_methods_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';

class ChooseExistingCards extends StatefulWidget {
  const ChooseExistingCards({super.key});

  @override
  State<ChooseExistingCards> createState() => _ChooseExistingCardsState();
}

class _ChooseExistingCardsState extends State<ChooseExistingCards> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
        ),
        ImageLayoutWidget(
          vpad: 10,
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ContainerAppbar(title: 'Choose Existing Card'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: kgrey2),
              ),
              SizedBox(
                height: 30,
              ),
              Consumer<PaymentMethodsProvider>(
                builder: (context, provider, _) {
                  final paymentMethods = provider.paymentMethods;

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentMethods?.length ?? 0,
                    itemBuilder: (context, index) {
                      final method = paymentMethods?[index];
                      final cardBrand =
                          provider.detectCardBrand(method!.cardNumber!);
                      final cardImage = cardBrand == 'mastercard'
                          ? Assets.imagesMastercard
                          : Assets.imagesVisa;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () => provider.selectMethod(index),
                          child: choose_card(
                            isActive: provider.selectedMethod == method,
                            img: cardImage,
                            title: '${cardBrand} ${method.cardNumber}',
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
          buttonText: 'Use card',
          ontap: () {
            context.read<CartProvider>().saveCard(context
                .read<PaymentMethodsProvider>()
                .selectedMethod!
                .cardNumber!);
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentMethodsProvider>().loadPaymentMethods();
    });
  }
}

class choose_card extends StatelessWidget {
  final String? title, img;
  final bool showIsActive;
  final bool? isActive;
  const choose_card({
    super.key,
    this.title,
    this.img,
    this.showIsActive = true,
    this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonImageView(
          imagePath: img ?? Assets.imagesVisa,
          width: 42,
          height: 28,
          fit: BoxFit.contain,
        ),
        Expanded(
            child: MyText(
          text: title ?? 'Visa ****1235',
          color: kdargrey,
          size: 16,
          paddingLeft: 10,
          weight: FontWeight.w500,
          useCustomFont: true,
        )),
        if (showIsActive)
          CustomCheckBox(
            isActive: isActive ?? false,
            onTap: () {},
            iscircle: true,
            circleIcon: Icons.check,
            iconColor: kwhite,
            selectedColor: kgreen,
            bordercolor2: ktransparent,
          )
      ],
    );
  }
}
