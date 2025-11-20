import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class CuratedBrands extends StatefulWidget {
  const CuratedBrands({super.key});

  @override
  State<CuratedBrands> createState() => _CuratedBrandsState();
}

class _CuratedBrandsState extends State<CuratedBrands> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: ListView(
                  children: [
                    MyText(
                      paddingTop: 25,
                      text: 'Take a look at these brands!',
                      size: 24,
                      color: kblack2,
                      weight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      paddingBottom: 20,
                    ),
                    GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: brands.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 130),
                      itemBuilder: (context, index) {
                        final brand = brands[index];
                        return curated_brand_widget(
                          img: brand["image"]!,
                          title: brand["title"]!,
                          desc: brand["subtitle"]!,
                        );
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

//
class curated_brand_widget extends StatelessWidget {
  final String? img, title, desc, networkImg;
  final double? size, radius;
  final bool? useCustomFont;
  final BoxFit? fit;
  const curated_brand_widget(
      {super.key,
      this.img,
      this.title,
      this.desc,
      this.useCustomFont = false,
      this.size,
      this.radius,
      this.fit,
      this.networkImg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonImageView(
          imagePath: img,
          url: networkImg,
          width: size ?? 77,
          height: size ?? 77,
          fit: fit ?? BoxFit.contain,
          radius: radius ?? 100,
        ),
        const SizedBox(height: 10),
        TwoTextedColumn(
          text1: title ?? '',
          text2: desc ?? '',
          size1: 10,
          size2: 7,
          color1: kblack,
          weight1: FontWeight.w700,
          color2: ktertiary,
          weight2: FontWeight.normal,
          alignment: ColumnAlignment.center,
          useCustomFont: useCustomFont,
        ),
      ],
    );
  }
}
