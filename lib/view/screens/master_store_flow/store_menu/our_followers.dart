import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/show_products/curated_brands.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/store_widgets/fotter.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

import '../../../../controllers/providers/brands_provider.dart';

class OurFollowers extends StatefulWidget {
  const OurFollowers({super.key});

  @override
  State<OurFollowers> createState() => _OurFollowersState();
}

class _OurFollowersState extends State<OurFollowers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<BrandsProvider>(builder: (context, ref, _) {
              return HeaderImageStack(
                showContent: false,
                store: ref.currentStore,
              );
            }),
//

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: TwoTextedColumn(
                text1: 'Here are the People Who Think We’re Cool',
                text2:
                    'We like showing off our friends and family. Here are some of their greatest hits!',
                color1: kheader,
                color2: kbody,
                weight1: FontWeight.w600,
                size1: 18,
                size2: 14,
                useCustomFont: true,
              ),
            ),
            Consumer<BrandsProvider>(builder: (context, ref, _) {
              final followers = ref.currentStore?.followers;
              if (followers == null || followers.isEmpty) {
                return Text("No followers found");
              }

              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: followers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 130),
                itemBuilder: (context, index) {
                  final brand = followers[index];
                  return Bounce_widget(
                    ontap: () {
                      // Navigator.of(context)
                      //     .push(CustomPageRoute(page: FollowerMaiProfile()));
                    },
                    widget: curated_brand_widget(
                      networkImg: brand.logo,
                      title: brand.name,
                      desc: brand.username,
                      useCustomFont: true,
                    ),
                  );
                },
              );
            }),
            SizedBox(
              height: 30,
            ),
            Consumer<BrandsProvider>(builder: (context, ref, _) {
              return StoreFotter(
                store: ref.currentStore,
              );
            })
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
      //   child: Store_Button_Row(),
      // ),
    );
  }
}
