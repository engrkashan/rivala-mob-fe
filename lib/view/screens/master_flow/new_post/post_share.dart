import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/post_model.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class PostShare extends StatefulWidget {
  final PostModel? post;
  const PostShare({super.key, this.post});

  @override
  State<PostShare> createState() => _PostShareState();
}

class _PostShareState extends State<PostShare> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final authorName = post?.author?.name ?? post?.author?.username ?? 'Anonymous';
    final authorHandle = post?.author?.username != null ? '@${post!.author!.username}' : '';
    final title = post?.title ?? 'Post';
    final shareLink = "https://rivala.com/post/${post?.id ?? ''}";

    return Scaffold(
        backgroundColor: Color(0xff404040),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 22),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Bounce_widget(
                    ontap: (){
                          Get.back();
                    },
                      widget: Image.asset(
                    Assets.imagesClose3,
                    width: 48,
                    height: 55,
                  ))),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: kblack.withOpacity(0.25),
                          blurRadius: 6,
                          spreadRadius: 4,
                          offset: Offset(4, 4),
                        ),
                      ]),
                      child: ClipOval(
                        child: CommonImageView(
                          url: post?.author?.avatarUrl,
                          imagePath: post?.author?.avatarUrl == null ? Assets.imagesApolo : null,
                          width: 93,
                          height: 93,
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: TwoTextedColumn(
                      text1: authorName,
                      text2: authorHandle,
                      size1: 22,
                      size2: 14,
                      color1: kwhite,
                      color2: kwhite,
                      weight1: FontWeight.bold,
                      weight2: FontWeight.w400,
                      alignment: ColumnAlignment.center,
                    ),
                  ),
                  MyText(
                    paddingBottom: 30,
                    paddingTop: 45,
                    text: 'Share “$title”',
                    size: 18,
                    weight: FontWeight.bold,
                    color: kwhite,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: CommonImageView(
                      imagePath: Assets.imagesQrcode,
                      width: 260,
                      radius: 15,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      children: [
                        Expanded(
                            child: Bounce_widget(
                                ontap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Downloading QR Code...')));
                                },
                                widget: Image.asset(
                          Assets.imagesDownloadqr,
                          height: 65,
                        ))),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Bounce_widget(
                                ontap: () async {
                                  await Clipboard.setData(ClipboardData(text: shareLink));
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Link copied to clipboard!')));
                                  }
                                },
                                widget: Image.asset(
                          Assets.imagesCopyqr,
                          height: 65,
                        )))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              Assets.imagesLogo1,
              color: kwhite,
              width: 45,
              height: 45,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
