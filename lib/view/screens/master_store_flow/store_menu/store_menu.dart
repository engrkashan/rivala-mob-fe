import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/collection_grid.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/main_profile.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/about_us.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/our_followers.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/my_links.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/shared_products.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class StoreMenu extends StatefulWidget {
  const StoreMenu({super.key});

  @override
  State<StoreMenu> createState() => _StoreMenuState();
}

class _StoreMenuState extends State<StoreMenu> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "text": "About Us",
        "ontap": () {
          Navigator.of(context).push(CustomPageRoute(page: AboutUs()));
          //  Get.to(() => AboutUs());
        }
      },
      {
        "text": "Shared Products",
        "ontap": () {
          Navigator.of(context).push(CustomPageRoute(page: SharedProducts()));
        }
      },
      {
        "text": "Our Posts",
        "ontap": () {
          Navigator.of(context).push(CustomPageRoute(
              page: CollectionGrid(
            text1: 'What We’ve Been Up To',
            text2:
                'Australian designed swimwear.⁣Worldwide shipping. Ethically made.',
          )));
        }
      },
      {
        "text": "Our Followers",
        "ontap": () {
           Navigator.of(context).push(CustomPageRoute(page: OurFollowers()));
        }
      },
      {
        "text": "Who We’re Following",
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
    return Scaffold(
        backgroundColor: kheader,
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
                  Image.asset(
                    Assets.imagesStorelogo,
                    height: 95,
                    width: 240,
                    fit: BoxFit.contain,
                    color: kblack,
                  ),
                  ExpandableSelectionTile(
                    title: 'Our Products',
                    options: [
                      {"text": "New Arrivals", "onTap": () {
                         Navigator.of(context).push(CustomPageRoute(page:StoreMainProfile()));
                      }},
                      {
                        "text": "Men",
                        "onTap": () {
                           Navigator.of(context).push(CustomPageRoute(page:StoreMainProfile()));
                          // Get.to(() => StoreMainProfile());
                        }
                      },
                      {"text": "Women", "onTap": () {
                         Navigator.of(context).push(CustomPageRoute(page:StoreMainProfile()));
                      }},
                    ],
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
                  Store_Button_Row()
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

  const ExpandableSelectionTile({
    Key? key,
    required this.title,
    required this.options,
    this.initialValue = '',
    this.onChanged,
  }) : super(key: key);

  @override
  _ExpandableSelectionTileState createState() =>
      _ExpandableSelectionTileState();
}

class _ExpandableSelectionTileState extends State<ExpandableSelectionTile> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue.isNotEmpty
        ? widget.initialValue
        : widget.options.first['text']; // Extract text from map
  }

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
               Navigator.of(context).push(CustomPageRoute(page: CollectionGrid(
                    text1: 'The Apollo and Sage Collection',
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
