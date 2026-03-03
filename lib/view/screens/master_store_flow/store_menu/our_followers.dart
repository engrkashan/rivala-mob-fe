import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/show_products/curated_brands.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/store_widgets/fotter.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

import '../../../../controllers/providers/brands_provider.dart';

class OurFollowers extends StatefulWidget {
  final int initialIndex;
  const OurFollowers({super.key, this.initialIndex = 0});

  @override
  State<OurFollowers> createState() => _OurFollowersState();
}

class _OurFollowersState extends State<OurFollowers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          backgroundColor: kwhite,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kblack),
            onPressed: () => Get.back(),
          ),
          bottom: TabBar(
            labelColor: kblack,
            unselectedLabelColor: Colors.grey,
            indicatorColor: kblack,
            tabs: const [
              Tab(text: "Followers"),
              Tab(text: "Following"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFollowersList(context, true),
            _buildFollowersList(context, false),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowersList(BuildContext context, bool isFollowers) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<BrandsProvider>(builder: (context, ref, _) {
            return HeaderImageStack(
              showContent: false,
              store: ref.currentStore,
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: TwoTextedColumn(
              text1: isFollowers
                  ? 'Here are the People Who Think We’re Cool'
                  : 'People We Are Currently Following',
              text2: isFollowers
                  ? 'We like showing off our friends and family. Here are some of their greatest hits!'
                  : 'Check out the amazing brands and people we follow.',
              color1: kheader,
              color2: kbody,
              weight1: FontWeight.w600,
              size1: 18,
              size2: 14,
              useCustomFont: true,
            ),
          ),
          Consumer<BrandsProvider>(builder: (context, ref, _) {
            final list = isFollowers
                ? ref.currentStore?.followers
                : ref.currentStore?.followings;
            if (list == null || list.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(22.0),
                child: Center(
                    child: Text(isFollowers
                        ? "No followers found"
                        : "Not following anyone yet")),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 130),
              itemBuilder: (context, index) {
                final brand = list[index];
                return Bounce_widget(
                  ontap: () {
                    // Navigate to follower/following profile
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
          SizedBox(height: 30),
          Consumer<BrandsProvider>(builder: (context, ref, _) {
            return StoreFotter(
              store: ref.currentStore,
            );
          })
        ],
      ),
    );
  }
}
