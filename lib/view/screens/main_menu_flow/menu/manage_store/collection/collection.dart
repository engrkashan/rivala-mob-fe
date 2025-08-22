import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/collection/manage_collection.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/collection/new_collection.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/main_menu_widgets/commission_widgets.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class CollectionMain extends StatefulWidget {
  const CollectionMain({super.key});

  @override
  State<CollectionMain> createState() => _CollectionMainState();
}

class _CollectionMainState extends State<CollectionMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context, title: 'Collections', centerTitle: true),
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
                      Get.bottomSheet(NewCollection(),
                          isScrollControlled: true);
                    },
                    icon: Assets.imagesAdd3,
                    title: ' Create new collection',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: collection_container(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class collection_container extends StatelessWidget {
  const collection_container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      radius: 15,
      hasShadow: true,
      color: kwhite,
      hpad: 12,
      vpad: 12,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: 'Hiking Essentials',
            color: kblack,
            weight: FontWeight.w500,
            size: 15,
            paddingBottom: 20,
          ),
          horizontal_img_list(),
          MyText(
            text: '> Manage collection',
            color: kblue,
            weight: FontWeight.w500,
            size: 12,
            paddingTop: 15,
            paddingBottom: 10,
            onTap: () {
              Navigator.of(context).push(
                CustomPageRoute(page: ManageCollection()),
              );
            },
          ),
          Row(
            children: [
              buttonContainer(
                text: 'Delete Collection',
                bgColor: kred,
                radius: 5,
                vPadding: 4,
                textsize: 10,
                hPadding: 3,
                txtColor: kblack,
                weight: FontWeight.normal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
