import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_tags.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

import '../../../../../controllers/providers/product_provider.dart';

class SearchCriteriaProducts extends StatefulWidget {
  final bool? hasCheckbox, isMainMenu, isSquad;
  final String? title, hintText;
  const SearchCriteriaProducts(
      {super.key,
      this.hasCheckbox = true,
      this.title,
      this.hintText,
      this.isMainMenu = false,
      this.isSquad = false});

  @override
  State<SearchCriteriaProducts> createState() => _SearchCriteriaProductsState();
}

class _SearchCriteriaProductsState extends State<SearchCriteriaProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        context.read<ProductProvider>().loadCurrentProducts();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: kwhite),
        padding: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ContainerAppbar(
            textColor: kblack,
            title: widget.title ?? 'Filter By',
            icon: Assets.imagesClose2,
          ),
          SizedBox(
            height: 25,
          ),
          MyTextField(
            hint: widget.hintText ?? 'Search Products',
            prefixIcon: Image.asset(
              Assets.imagesSearch,
              width: 15,
              height: 15,
            ),
            ontapp: () {
              Get.back();
              Get.bottomSheet(SearchCriteriaProducts(),
                  isScrollControlled: true);
            },
            contentvPad: 6,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, ref, _) {
                return ListView.builder(
                  itemCount: ref.prds?.length ?? 0,
                  itemBuilder: (context, switchIndex) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: tags_search_row(
                          size: 54,
                          hpad: 0,
                          bgColor: ktransparent,
                          isProduct: true,
                          product: ref.prds?[switchIndex],
                          hasCheckbox: widget.hasCheckbox,
                          isMainMenu: widget.isMainMenu,
                          isSquad: widget.isSquad,
                        ));
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ]));
  }
}
