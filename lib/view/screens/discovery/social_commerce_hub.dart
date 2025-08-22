import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/discovery/search_discovery_products.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/show_products/curated_brands.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class SocialCommerceHub extends StatefulWidget {
  const SocialCommerceHub({super.key});

  @override
  State<SocialCommerceHub> createState() => _SocialCommerceHubState();
}

class _SocialCommerceHubState extends State<SocialCommerceHub> {
  final List<Map<String, String>> brands = [
    {
      "image": Assets.imagesFitness,
      "title": "Fitness Culture Gym",
      "subtitle": "@fitnessculture"
    },
    {
      "image": Assets.imagesNutrition,
      "title": "Elite Sports",
      "subtitle": "@elitesports"
    },
    {
      "image": Assets.imagesItovi,
      "title": "iTOVi",
      "subtitle": "@adventuretravel"
    },
    {
      "image": Assets.imagesNutrition,
      "title": "Nutrition Rescue",
      "subtitle": "@glowbeauty"
    },
    {
      "image": Assets.imagesItovi,
      "title": "iTOVi",
      "subtitle": "@trendyapparel"
    },
    {
      "image": Assets.imagesFitness,
      "title": "Fitness Culture Gym",
      "subtitle": "@creativestudio"
    },
    {
      "image": Assets.imagesNutrition,
      "title": "Nutrition Rescue",
      "subtitle": "@glowbeauty"
    },
    {
      "image": Assets.imagesItovi,
      "title": "Trendy Apparel",
      "subtitle": "@trendyapparel"
    },
    {
      "image": Assets.imagesFitness,
      "title": "Protagonist",
      "subtitle": "@creativestudio"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Image.asset(
                Assets.imagesRivalalogo,
                height: 33,
                width: 148,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: MyTextField(
                hint: 'Search products',
                bordercolor: kgrey2,
                filledColor: ktransparent,
                contentvPad: 6.5,
                radius: 45,
                prefixIcon: Image.asset(
                  Assets.imagesSearch,
                  width: 15,
                ),
                readOnly: true,
                ontapp: () {
                      Navigator.of(context).push(CustomPageRoute(page:SearchDiscoveryProducts()),);
                  
                },
              ),
            ),
            MyText(
              text: 'Recent Brands',
              size: 20,
              weight: FontWeight.bold,
              color: kblack2,
              paddingLeft: 22,
              paddingBottom: 10,
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        curated_brand_widget(
                          size: 135,
                          img: brand["image"]!,
                          title: brand["title"]!,
                          desc: brand["subtitle"]!,
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            MyText(
              text: 'Recent Products',
              size: 20,
              weight: FontWeight.bold,
              color: kblack2,
              paddingLeft: 22,
              paddingTop: 15,
              paddingBottom: 10,
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        curated_brand_widget(
                          size: 135,
                          radius: 20,
                          fit: BoxFit.cover,
                          img: Assets.imagesNutrition2,
                          title: 'Cy tidewell',
                          desc: '@cytidwell',
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            MyText(
              text: 'Recent Creators',
              size: 20,
              weight: FontWeight.bold,
              color: kblack2,
              paddingLeft: 22,
              paddingTop: 15,
              paddingBottom: 10,
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        curated_brand_widget(
                          size: 135,
                          radius: 100,
                          fit: BoxFit.cover,
                          img: Assets.imagesDummyimage2,
                          title: 'Cy tidewell',
                          desc: '@cytidwell',
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
              child: row_widget(
                title: 'High Earning Products',
                texSize: 20,
                weight: FontWeight.bold,
                icon: Assets.imagesEarned,
                isIconRight: true,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        curated_brand_widget(
                          size: 135,
                          radius: 20,
                          fit: BoxFit.cover,
                          img: Assets.imagesEcuador,
                          title: 'Cy tidewell',
                          desc: '@cytidwell',
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
              child: row_widget(
                title: 'Back to School',
                texSize: 20,
                weight: FontWeight.bold,
                icon: Assets.imagesSchool,
                isIconRight: true,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        curated_brand_widget(
                          size: 135,
                          radius: 20,
                          fit: BoxFit.cover,
                          img: Assets.imagesNutrition2,
                          title: 'Cy tidewell',
                          desc: '@cytidwell',
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
              child: row_widget(
                title: 'Trending',
                texSize: 20,
                weight: FontWeight.bold,
                icon: Assets.imagesTrending,
                isIconRight: true,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        curated_brand_widget(
                          size: 135,
                          radius: 20,
                          fit: BoxFit.cover,
                          img: Assets.imagesEcuador,
                          title: 'Cy tidewell',
                          desc: '@cytidwell',
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
              child: row_widget(
                title: 'Community Feed ',
                texSize: 20,
                weight: FontWeight.bold,
                icon: Assets.imagesTrending,
                isIconRight: true,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        CommonImageView(
                          imagePath: Assets.imagesDummyimage2,
                          height: 330,
                          width: 225,
                          radius: 20,
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
              child: row_widget(
                title: 'Picks for You',
                texSize: 20,
                weight: FontWeight.bold,
                icon: Assets.imagesProfileicon,
                isIconRight: true,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        curated_brand_widget(
                          size: 135,
                          radius: 20,
                          fit: BoxFit.cover,
                          img: Assets.imagesNutrition2,
                          title: 'Cy tidewell',
                          desc: '@cytidwell',
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
              child: row_widget(
                title: 'Local Products',
                texSize: 20,
                weight: FontWeight.bold,
                icon: Assets.imagesLocal,
                isIconRight: true,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(brands.length, (index) {
                  final brand = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Column(
                      children: [
                        curated_brand_widget(
                          size: 135,
                          radius: 20,
                          fit: BoxFit.cover,
                          img: Assets.imagesEcuador,
                          title: 'Cy tidewell',
                          desc: '@cytidwell',
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }
}
