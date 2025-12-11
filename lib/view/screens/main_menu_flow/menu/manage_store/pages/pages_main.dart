import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/pages_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/create_new_page.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/pages/pages_aboutUs.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class PagesMain extends StatefulWidget {
  const PagesMain({super.key});

  @override
  State<PagesMain> createState() => _PagesMainState();
}

class _PagesMainState extends State<PagesMain> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PagesProvider>().loadAllPages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar:
            simpleAppBar(context: context, title: 'Pages', centerTitle: true),
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
                  row_widget(
                    onTap: () {
                      Get.bottomSheet(CreateNewPage(),
                          isScrollControlled: true);
                    },
                    icon: Assets.imagesAdd3,
                    title: ' Create new page',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyText(
                    text: 'Custom Pages',
                    size: 15,
                    weight: FontWeight.w500,
                    color: kblack,
                    paddingBottom: 15,
                  ),
                  // Dynamic Custom Pages
                  Consumer<PagesProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (provider.pages.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("No custom pages found."),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: provider.pages.length,
                        itemBuilder: (context, index) {
                          final page = provider.pages[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ShoppingRow(
                              textt: page.title ?? 'Untitled Page',
                              icon: Assets.imagesPages,
                              textSize: 15,
                              weight: FontWeight.w500,
                              mleft: 0,
                              isSelected: false,
                              ontap: () {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                      page: PagesAboutus(page: page)),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),

                  MyText(
                    text: 'Auto Generated Pages',
                    size: 15,
                    weight: FontWeight.w500,
                    color: kblack,
                    paddingBottom: 15,
                    paddingTop: 15,
                  ),
                  // Last 3 items (Static for now as placeholders)
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final List<Map<String, dynamic>> staticItems = [
                        {
                          'text': 'Your Products',
                          'delay': 550,
                          'onTap': () => Navigator.of(context)
                              .push(CustomPageRoute(page: PagesAboutus()))
                        },
                        {
                          'text': 'Your Posts',
                          'delay': 700,
                          'onTap': () => Navigator.of(context)
                              .push(CustomPageRoute(page: PagesAboutus()))
                        },
                        {
                          'text': 'Your Followers',
                          'delay': 850,
                          'onTap': () => Navigator.of(context)
                              .push(CustomPageRoute(page: PagesAboutus()))
                        },
                      ];
                      final item = staticItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: ShoppingRow(
                          textt: item['text'],
                          icon: Assets.imagesPages,
                          delay: item['delay'],
                          textSize: 15,
                          weight: FontWeight.w500,
                          mleft: 0,
                          isSelected: false,
                          ontap: () {
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              item['onTap']();
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
