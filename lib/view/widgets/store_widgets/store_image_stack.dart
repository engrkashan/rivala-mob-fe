import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/store_model.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/our_followers.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/store_menu.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

//header image container

class HeaderImageStack extends StatelessWidget {
  final bool? showContent;
  final StoreModel? store;
  const HeaderImageStack({super.key, this.showContent = true, this.store});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: CommonImageView(
            imagePath: Assets.imagesDummyImg, // Maybe store cover image?
            url: store?.owner?.avatarUrl,
            width: Get.width,
            height: 300, // Fixed height for cover
            fit: BoxFit.cover,
          ),
        ),

        // Centered Content
        Positioned(
          top: 50, // Adjust this value if needed
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CommonImageView(
                imagePath: Assets.imagesProfileapolo,
                url: store?.logoUrl,
                width: 80,
                height: 80,
                radius: 100,
              ),

              // Profile Name
              MyText(
                text: store?.name ?? 'Apollo & Sage',
                color: kwhite,
                size: 22,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
                useCustomFont: true,
              ),

              // Likes & Username
              MyText(
                text: '@${store?.owner?.username ?? "apollo.and.sage"} ',
                color: kwhite,
                size: 12,
                weight: FontWeight.w400,
                paddingBottom: 8,
                useCustomFont: true,
              ),
              if (showContent == true) ...{
                // Description
                MyText(
                  paddingTop: 15,
                  text: store?.owner?.bio ??
                      'Australian designed swimwear.\nWorldwide shipping. Ethically made.',
                  color: kwhite,
                  size: 12,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w400,
                  paddingBottom: 15,
                  useCustomFont: true,
                ),

                // Followers & Following Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: buttonContainer(
                          onTap: () => Get.to(() => OurFollowers()),
                          text: '  Followers',
                          bgColor: ksecondary.withOpacity(0.2),
                          txtColor: kwhite,
                          textsize: 11,
                          hPadding: 30,
                          vPadding: 7,
                          useCustomFont: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buttonContainer(
                          onTap: () => Get.to(() => OurFollowers()),
                          text: '  Following',
                          bgColor: ksecondary.withOpacity(0.2),
                          txtColor: kwhite,
                          textsize: 11,
                          hPadding: 30,
                          vPadding: 7,
                          useCustomFont: true,
                        ),
                      ),
                    ],
                  ),
                ),
              }
            ],
          ),
        ),

        // Menu Button at Top Left
        Positioned(
          top: 40,
          left: 22,
          child: Bounce_widget(
            ontap: () {
              Navigator.of(context).push(CustomPageRoute(
                  page: StoreMenu(
                store: store,
              )));
              // Get.to(StoreMenu());
            },
            widget: Image.asset(
              Assets.imagesMenubutton,
              width: 46,
              height: 46,
            ),
          ),
        ),
      ],
    );
  }
}

/////
class store_image_stack extends StatelessWidget {
  final double? height, iconSize, width, radius;
  final bool? showContent, showShadow, quickbut, showIcon, singlePrice;
  final String? title, price, icon, url;
  final Color? contentColor;
  final void Function()? onTap;
  const store_image_stack({
    super.key,
    this.height,
    this.showContent = true,
    this.iconSize,
    this.showShadow = true,
    this.quickbut = false,
    this.showIcon = true,
    this.width,
    this.radius,
    this.title,
    this.price,
    this.singlePrice = false,
    this.contentColor,
    this.icon,
    this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 15),
                  boxShadow: showShadow == true
                      ? [
                          BoxShadow(
                            color: kgrey4,
                            blurRadius: 4,
                            spreadRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ]
                      : []),
              child: Bounce_widget(
                ontap: onTap,
                widget: CommonImageView(
                  imagePath: url ?? Assets.imagesDummyImg,
                  url: url,
                  height: height ?? 360,
                  width: width ?? Get.width * 0.6,
                  radius: radius ?? 15,
                ),
              ),
            ),
            if (quickbut == false && showIcon == true)
              Positioned(
                bottom: 10,
                right: 10,
                child: Bounce_widget(
                  widget: Image.asset(
                    icon ?? Assets.imagesStoretag,
                    width: iconSize ?? 40,
                    height: iconSize ?? 40,
                  ),
                ),
              ),
            if (quickbut == true)
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: Row(
                    children: [
                      buttonContainer(
                        icon: Icons.add,
                        iconColor: kwhite,
                        bgColor: kblack2.withOpacity(0.5),
                        text: 'Quick Add',
                        useCustomFont: true,
                      )
                    ],
                  )),
          ],
        ),
        if (showContent == true) ...{
          SizedBox(
            height: 6,
          ),
          MyText(
            text: title ?? 'Blue Floral Short',
            color: contentColor ?? kheader,
            weight: FontWeight.w600,
            useCustomFont: true,
            size: 13,
          ),
          Row(
            children: [
              if (singlePrice == false)
                MyText(
                  text: price ?? '\$69.00 USD',
                  color: contentColor ?? kheader,
                  weight: FontWeight.w400,
                  size: 9,
                  decoration: TextDecoration.lineThrough,
                  useCustomFont: true,
                ),
              MyText(
                text: "\$${price}" ?? '\$50.00 USD',
                color: contentColor ?? kheader,
                weight: FontWeight.w400,
                size: 9,
                useCustomFont: true,
              ),
            ],
          )
        }
      ],
    );
  }
}

///

class horizontal_slider extends StatelessWidget {
  const horizontal_slider({
    super.key,
    required double progress,
    this.color,
    this.pColor,
  }) : _progress = progress;

  final double _progress;
  final Color? color, pColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Container(
            height: 3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color ?? ktertiary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: _progress * (MediaQuery.of(context).size.width - 170),
                  child: Container(
                    width: 30,
                    height: 3,
                    decoration: BoxDecoration(
                      color: pColor ?? ktertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
