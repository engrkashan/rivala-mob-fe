import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/follow_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_store_flow/store_menu/following_profile.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/button_container.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/switch_button.dart';

import '../../../../../models/follow_model.dart';

class FollowingsManualAdd extends StatefulWidget {
  final String? title, hintText;
  final bool? follower;
  const FollowingsManualAdd(
      {super.key, this.title, this.follower = false, this.hintText});

  @override
  State<FollowingsManualAdd> createState() => _FollowingsManualAddState();
}

class _FollowingsManualAddState extends State<FollowingsManualAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: widget.title ?? 'Following',
            centerTitle: true),
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
                  SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    hint: widget.hintText ?? 'Search who you’re following',
                    prefixIcon: Image.asset(
                      Assets.imagesSearch,
                      width: 12,
                    ),
                    contentvPad: 5,
                  ),
                  if (widget.follower == true)
                    Row(
                      children: [
                        Expanded(
                          child: MyText(
                              text: 'Automatically accept all followers',
                              size: 15,
                              color: kblack,
                              weight: FontWeight.w500,
                              paddingBottom: 0),
                        ),
                        SwitchButton(
                          scale: 0.6,
                          isActive: true,
                        )
                      ],
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  Consumer<FollowProvider>(builder: (context, following, _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: following.following.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: manual_add_row(
                            isFollowing: index == 1 ? true : false,
                            buttonText:
                                widget.follower == true ? 'Remove' : 'Unfollow',
                            following: following.following[index],
                          ),
                        );
                      },
                    );
                  })
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FollowProvider>().loadFollowings();
    });
  }
}

class manual_add_row extends StatelessWidget {
  final String? text1, text2, img, buttonText;
  final Color? color1, color2;
  final double? size1, size2, mbot;
  final FontWeight? weight2;
  final bool? isFollowing, isButton;
  final VoidCallback? ontap;
  final FollowModel? following;
  const manual_add_row({
    super.key,
    this.text1,
    this.text2,
    this.img,
    this.isFollowing = false,
    this.buttonText,
    this.color1,
    this.color2,
    this.size1,
    this.size2,
    this.isButton = true,
    this.weight2,
    this.mbot,
    this.ontap,
    this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap ??
          () {
            Navigator.of(context)
                .push(CustomPageRoute(page: FollowerMaiProfile()));

            /// Get.to(() => FollowerMaiProfile());
          },
      widget: Row(
        children: [
          CommonImageView(
            url: following?.avatarUrl,
            imagePath: following?.avatarUrl ?? img ?? Assets.imagesProfileicon,
            width: 54,
            height: 54,
            radius: 100,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: TwoTextedColumn(
            text1: isFollowing == true ? 'Following' : "Followed Back",
            text2: following?.name ?? 'Nutrition Rescue',
            size1: size1 ?? 11,
            size2: size2 ?? 14,
            color1: isFollowing == true ? kgreen : color1 ?? kblue,
            color2: color2 ?? kblack,
            weight2: weight2 ?? FontWeight.w500,
            mBottom: mbot ?? 0,
          )),
          if (isButton == true)
            buttonContainer(
              text: buttonText ?? 'remove',
              textsize: 10,
              txtColor: kblack,
              vPadding: 4,
              hPadding: 10,
              radius: 5,
              bgColor: ktertiary,
            ),
          if (isButton == false) MyText(text: '5m ago')
        ],
      ),
    );
  }
}
