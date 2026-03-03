import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/color_converter.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/collection_grid.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/product_detailed_description.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/my_links.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/our_followers.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../models/store_model.dart';

class StoreMenu extends StatefulWidget {
  final StoreModel? store;
  const StoreMenu({super.key, this.store});

  @override
  State<StoreMenu> createState() => _StoreMenuState();
}

class _StoreMenuState extends State<StoreMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadCurrentProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      // ....existing commented out items...
      {
        "text": "Our Followers",
        "ontap": () {
          Navigator.of(context).push(CustomPageRoute(page: OurFollowers()));
        }
      },
      {
        "text": "Who We're Following",
        "ontap": () {
          Navigator.of(context).push(CustomPageRoute(page: OurFollowers()));
        }
      },
      {
        "text": "Our Links",
        "ontap": () {
          Navigator.of(context).push(CustomPageRoute(page: MyLinks()));
        }
      },
    ];
    final themeColor = widget.store?.theme?.colorDark;
    final bgColor = themeColor != null ? hexToColor(themeColor) : kheader;
    return Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 22),
                  child: Bounce_widget(
                      ontap: () {
                        Navigator.pop(context);
                      },
                      widget: Image.asset(
                        Assets.imagesBackicon2,
                        width: 46,
                        height: 46,
                      )),
                )),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  MyText(
                    text: widget.store?.name ?? 'Store Name',
                    size: 26,
                    color: kblack,
                    weight: FontWeight.bold,
                    paddingTop: 10,
                    paddingBottom: 20,
                    useCustomFont: true,
                  ),
                  Consumer<ProductProvider>(
                    builder: (context, productProvider, _) {
                      final products = productProvider.prds ?? [];
                      return ExpandableSelectionTile(
                        title: 'Our Products',
                        options: products
                            .map((p) => {
                                  "text": p.title ?? 'Untitled',
                                  "onTap": () {
                                    Navigator.of(context).push(
                                      CustomPageRoute(
                                        page: ProductDetailedDescription(
                                          product: p,
                                        ),
                                      ),
                                    );
                                  },
                                })
                            .toList(),
                        storeName: widget.store?.name,
                        store: widget.store,
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return Bounce_widget(
                        ontap: menuItems[index]['ontap'],
                        widget: MyText(
                          text: menuItems[index]['text'],
                          size: 20,
                          color: kblack,
                          weight: FontWeight.bold,
                          paddingBottom: 17,
                          useCustomFont: true,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Store_Button_Row()
                ],
              ),
            ),
          ],
        ));
  }
}

//

class ExpandableSelectionTile extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> options; // Now holds text & ontap
  final String initialValue;
  final ValueChanged<String>? onChanged;
  final String? storeName;
  final StoreModel? store;

  const ExpandableSelectionTile({
    Key? key,
    required this.title,
    required this.options,
    this.initialValue = '',
    this.onChanged,
    this.storeName,
    this.store,
  }) : super(key: key);

  @override
  _ExpandableSelectionTileState createState() =>
      _ExpandableSelectionTileState();
}

class _ExpandableSelectionTileState extends State<ExpandableSelectionTile> {
  late String selectedValue;

  @override
  // void initState() {
  //   super.initState();
  //   selectedValue = widget.initialValue.isNotEmpty
  //       ? widget.initialValue
  //       : widget.options.first['text']; // Extract text from map
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          dividerColor: ktransparent,
          expansionTileTheme: const ExpansionTileThemeData()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          iconColor: kblack,
          title: MyText(
            text: widget.title,
            size: 20,
            color: kblack,
            useCustomFont: true,
            weight: FontWeight.bold,
            onTap: () {
              Navigator.of(context).push(CustomPageRoute(
                  page: CollectionGrid(
                store: widget.store,
                text1: '${widget.storeName}',
                text2:
                    'All of our Aussie-inspired swim wear featuring stylish and sustainable designs for men and women. ',
              )));
              // Get.to(() => CollectionGrid(
              //       text1: 'The Apollo and Sage Collection',
              //       text2:
              //           'All of our Aussie-inspired swim wear featuring stylish and sustainable designs for men and women. ',
              //     ));
            },
          ),
          children: widget.options.map((option) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedValue = option['text'];
                });
                if (option['onTap'] != null) {
                  option['onTap']!(); // Execute specific function
                }
                if (widget.onChanged != null) {
                  widget.onChanged!(option['text']);
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyText(
                          text: option['text'],
                          color: ksubHeader,
                          size: 20,
                          textAlign: TextAlign.start,
                          useCustomFont: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
