import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/consts/app_fonts.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/show_products/curated_brands.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';

import '../product_setup_success.dart';
import 'curative_products.dart';

class ShowProducts extends StatefulWidget {
  const ShowProducts({super.key});

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
    final List<Widget> tabBarView = [CuratedBrands(), CurativeProducts()];
  final List<String> _tabs = [
    "Products",
    'Brands',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
          backgroundColor: kwhite,
                appBar: simpleAppBar(context: context,centerTitle: true, actions: [
          Bounce_widget(
            ontap: (){     Get.to(() => GradientSuccessScreen());},
            widget: Text(
              'Skip',
              style: TextStyle(
                shadows: [Shadow(color: ktertiary, offset: Offset(0, -3))],
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decorationColor: ktertiary,
                decorationThickness: 1,
                decorationStyle: TextDecorationStyle.solid,
                fontFamily: AppFonts.poppins,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(width: 12),
        ]),
           body: NestedScrollView(
            physics: BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 50,
                  centerTitle: false,
                  backgroundColor: kwhite,
                  surfaceTintColor: kwhite,
                  pinned: true,
                  floating: false,
                  leading: null,
                  iconTheme: IconThemeData(color: Colors.transparent),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        color: kwhite,
                        border: Border(bottom: BorderSide(color: kgrey2),
                        top: BorderSide(color: kgrey2))
                      ),
                      width: double.infinity,
                      height: 50,
                      child: TabBar(
                        automaticIndicatorColorAdjustment: false,
                        labelColor: kblack,
                        unselectedLabelColor: ktertiary,
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.poppins,
                            color: kblack),
                        unselectedLabelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: AppFonts.poppins,
                            color: ktertiary),
                        // controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        dividerColor: ktransparent,
                        indicatorColor: kblack2,
                        labelPadding: EdgeInsets.zero,
                        tabs: List.generate(
                          _tabs.length,
                          (index) => Tab(
                            text: _tabs[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
                physics: BouncingScrollPhysics(), children: tabBarView),
          ),
        ),
    );

  }
}