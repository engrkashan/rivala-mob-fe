import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/promo_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/promotions_model.dart'; // Assuming PromotionModel is defined here or in promo_provider.dart
import 'package:rivala/view/screens/master_flow/new_post/add_promo/start_new_promo.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class AddPromo extends StatefulWidget {
  final Function(PromotionModel)? onSelect;
  final bool isSelectable;
  final List<PromotionModel>? alreadySelected;

  const AddPromo({
    super.key,
    this.onSelect,
    this.isSelectable = false,
    this.alreadySelected,
  });

  @override
  State<AddPromo> createState() => _AddPromoState();
}

class _AddPromoState extends State<AddPromo> {
  final List<PromotionModel> _currentSelected = [];

  @override
  void initState() {
    super.initState();
    if (widget.alreadySelected != null) {
      _currentSelected.addAll(widget.alreadySelected!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PromoProvider>(
      builder: (context, ref, _) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: kwhite,
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ContainerAppbar(
                    title: 'Promos',
                    textColor: kblack,
                    icon: Assets.imagesClose2,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    hint: 'search promo',
                    label: 'Promo Name',
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ref.promos.length,
                    itemBuilder: (context, i) {
                      final promo = ref.promos[i];
                      final isSelected = _currentSelected
                          .any((element) => element.id == promo.id);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          onTap: () {
                            if (widget.isSelectable) {
                              setState(() {
                                if (isSelected) {
                                  _currentSelected.removeWhere(
                                      (item) => item.id == promo.id);
                                } else {
                                  _currentSelected.add(promo);
                                }
                              });
                              widget.onSelect?.call(promo);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(text: promo.title ?? ""),
                              if (widget.isSelectable && isSelected)
                                const Icon(Icons.check_circle, color: kgreen2)
                              else if (widget.isSelectable)
                                const Icon(Icons.radio_button_unchecked,
                                    color: ktertiary),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  MyText(
                    text: '+ Add New Promo',
                    color: kblue,
                    weight: FontWeight.w500,
                    size: 12,
                    paddingBottom: 30,
                    paddingTop: 20,
                    onTap: () {
                      Get.to(() => const StartNewPromo(
                            color: kgreen2,
                            buttonText: 'Save promo',
                          ));
                    },
                  ),
                  MyButton(
                    buttonText: widget.isSelectable ? 'Done' : 'Save variant',
                    mBottom: 30,
                    onTap: () {
                      if (widget.isSelectable) {
                        Get.back(result: _currentSelected);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
