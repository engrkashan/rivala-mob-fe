import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/add_promo/search_criteria_products.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/main_menu_widgets/commission_widgets.dart';
import 'package:rivala/view/widgets/main_menu_widgets/stats.graph.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class CommissionEarned extends StatefulWidget {
  final String? title;
  final bool? hascart;
  const CommissionEarned({super.key, this.title, this.hascart=false});

  @override
  State<CommissionEarned> createState() => _CommissionEarnedState();
}

class _CommissionEarnedState extends State<CommissionEarned> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,
            title:widget.title?? 'Commissions Earned', centerTitle: true, size: 18),
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
                  if(widget.hascart==true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(text:widget.title?? 'Commissions Paid',size: 22,color: kblack,weight: FontWeight.w600,),
                      circular_icon_container(
                     size: 45,
                     iconSize: 22,
                      )
                    ],
                  ),
                  MyGradientText(
                    text: '\$2,000.05',
                    size: 35,
                    weight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      MyText(
                        text: '\$1,001.96',
                        size: 11,
                        paddingRight: 8,
                      ),
                      buttonContainer(
                        bgColor: kred,
                        textsize: 10,
                        vPadding: 2,
                        hPadding: 3,
                        text: 'Pending',
                        radius: 8,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomDateSelector(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      row_widget(
                        onTap: (){
                          Get.bottomSheet(SearchCriteriaProducts(
                            hasCheckbox: false,
                          ),isScrollControlled: true);
                        },
                        icon: Assets.imagesFilter,
                        iconSize: 18,
                        texSize: 13,
                        title: 'Filter report',
                      ),
                      row_widget(
                        icon: Assets.imagesCsv,
                        iconSize: 18,
                        texSize: 13,
                        title: 'CSV Export',
                      )
                    ],
                  ),
                  LineGraph(),
                  MyText(
                    text: 'Last updated: 01/31/2025',
                    size: 11,
                    color: kblack.withOpacity(0.5),
                    paddingBottom: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: order_number_detail_container(),
                      );
                    },
                  ),
                  SizedBox(height: 80,)
                ],
              ),
            ),
          ],
        ));
  }
}

//
class CustomDateSelector extends StatefulWidget {
  @override
  _CustomDateSelectorState createState() => _CustomDateSelectorState();
}

class _CustomDateSelectorState extends State<CustomDateSelector> {
  int selectedIndex = 0; // Stores the selected tab index

  final List<String> options = ["24 HOURS", "7 DAYS", "30 DAYS", "CUSTOM DATE"];

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      vpad: 3,
      hpad: 5,
      radius: 8,
      color: ktertiary.withOpacity(0.2),
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(options.length, (index) {
          bool isSelected = selectedIndex == index;
          return Expanded(
            // Now correctly expands each item in the row
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                decoration: BoxDecoration(
                  color: isSelected ? kwhite : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: MyText(
                    text: options[index],
                    textOverflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    size: 11,
                    color: isSelected ? kblack : kblack.withOpacity(0.7),
                    weight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
