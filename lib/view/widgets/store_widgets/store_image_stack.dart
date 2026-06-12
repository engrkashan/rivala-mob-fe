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

import 'package:rivala/view/widgets/color_converter.dart';

//header image container

class HeaderImageStack extends StatelessWidget {
  final bool? showContent;
  final StoreModel? store;
  const HeaderImageStack({super.key, this.showContent = true, this.store});

  @override
  Widget build(BuildContext context) {
    // Use the theme nested directly in the store response
    final currentTheme = store?.theme;
    final coverUrl = store?.hero?.heroImageUrl ?? currentTheme?.coverImage ?? store?.owner?.avatarUrl;

    // Resolve theme color or default to grey
    Color backgroundColor = kdargrey;
    if (currentTheme?.color1 != null) {
      try {
        backgroundColor = hexToColor(currentTheme!.color1!);
      } catch (e) {
        backgroundColor = kdargrey;
      }
    }
    Color headerColor = kwhite; // Default fallback
    if (currentTheme?.color2 != null) {
      try {
        headerColor = hexToColor(currentTheme!.color2!);
      } catch (e) {
        headerColor = kwhite;
      }
    }
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: backgroundColor,
              child: (coverUrl != null && coverUrl.isNotEmpty)
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.35),
                        BlendMode.srcOver,
                      ),
                      child: CommonImageView(
                        url: coverUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),

        // Centered Content (dynamic size, drives Stack height)
        Padding(
          padding: const EdgeInsets.only(top: 80, bottom: 24, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Image / Initials
              if (store?.logoUrl != null && store!.logoUrl!.isNotEmpty)
                CommonImageView(
                  url: store?.logoUrl,
                  width: 80,
                  height: 80,
                  radius: 100,
                )
              else
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ksecondary,
                  ),
                  child: Center(
                    child: Text(
                      (store?.name ?? 'S').substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        color: kwhite,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),

              // Profile Name
              MyText(
                text: store?.name ?? "",
                color: headerColor,
                size: 22,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
                useCustomFont: true,
              ),

              // Likes & Username
              MyText(
                text: '@${store?.slug ?? store?.owner?.username ?? ""} · ${store?.counts?['likes'] ?? 0} Likes',
                color: headerColor.withOpacity(0.8),
                size: 12,
                weight: FontWeight.w400,
                paddingBottom: 8,
                useCustomFont: true,
              ),

              if (showContent == true) ...{
                // Description (store hero bodyText or owner bio)
                MyText(
                  paddingTop: 8,
                  text: store?.hero?.bodyText ?? store?.owner?.bio ?? '',
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
                          onTap: () =>
                              Get.to(() => OurFollowers(initialIndex: 0)),
                          text: '${store?.counts?['followers'] ?? 0} Followers',
                          bgColor: ksecondary.withOpacity(0.25),
                          txtColor: kwhite,
                          textsize: 11,
                          hPadding: 10,
                          vPadding: 7,
                          useCustomFont: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buttonContainer(
                          onTap: () =>
                              Get.to(() => OurFollowers(initialIndex: 1)),
                          text: '${store?.counts?['following'] ?? 0} Following',
                          bgColor: ksecondary.withOpacity(0.25),
                          txtColor: kwhite,
                          textsize: 11,
                          hPadding: 10,
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
                        icon: Icons.visibility,
                        iconColor: kwhite,
                        bgColor: kblack2.withOpacity(0.5),
                        text: 'Quick View',
                        useCustomFont: true,
                        onTap: onTap,
                      )
                    ],
                  )),
          ],
        ),
        if (showContent == true) ...{
          const SizedBox(
            height: 6,
          ),
          MyText(
            text: title ?? 'Blue Floral Short',
            color: contentColor ?? kheader,
            weight: FontWeight.w600,
            useCustomFont: true,
            size: 13,
          ),
          MyText(
            text: price != null ? '\$$price' : '\$50.00',
            color: contentColor ?? kheader,
            weight: FontWeight.w500,
            size: 12,
            useCustomFont: true,
          ),
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
