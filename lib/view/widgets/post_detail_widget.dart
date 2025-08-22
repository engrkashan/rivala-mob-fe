import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/animate_widgets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/switch_button.dart';

class PostDetailOptRow extends StatelessWidget {
  final String? title, icon, addedText, tagIcon;
  final bool? hasIcon, hasText, isFeatured;
  final double? hpad;
  final VoidCallback? ontap;
  final int? delay;
  final List<String>? tags; // Can be 1, 2, or 3 tags

  const PostDetailOptRow({
    super.key,
    this.title,
    this.icon,
    this.hasIcon = true,
    this.hpad,
    this.ontap,
    this.delay,
    this.tags,
    this.hasText = false,
    this.addedText,
    this.isFeatured,
    this.tagIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      delay: delay,
      child: Bounce_widget(
        ontap: ontap,
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: hpad ?? 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon ?? Assets.imagesFeatured,
                    width: 21.5,
                    height: 21.5,
                  ),
                  Expanded(
                    child: MyText(
                      text: title ?? 'Featured post',
                      color: kblack,
                      weight: FontWeight.w500,
                      size: 14,
                      paddingLeft: 13,
                    ),
                  ),
                  if (hasIcon == false) SwitchButton(scale: 0.7),
                  if (hasIcon == true && hasText == false)
                    Image.asset(
                      Assets.imagesForward,
                      width: 20,
                      fit: BoxFit.contain,
                      height: 20,
                    ),
                  if (hasIcon == true && hasText == true)
                    row_widget(
                      isIconRight: true,
                      iconSize: 20,
                      icon: Assets.imagesForward,
                      title: addedText ?? '01/08/2024, 10:00 AM',
                      texSize: 10,
                    )
                ],
              ),
              if (isFeatured == true)
                MyText(
                  text: 'Post will appear in the discovery feed',
                  color: ktertiary,
                  size: 13,
                ),

              /// If `tags` is not empty, display them
              if (tags != null && tags!.isNotEmpty) ...[
                const SizedBox(height: 7),

                // Condition to limit the number of tags dynamically
                Wrap(
                  spacing: 5,
                  children: tags!.take(3).map((tag) {
                    // Limits to 3 max
                    return TagsWidget(
                      tag: tag,
                      tagIcon: tagIcon,
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TagsWidget extends StatelessWidget {
  final String? tagIcon, tag;
  final Color? bgColor, fontColor;
  final bool? useCustomFont;
  const TagsWidget(
      {super.key, this.tagIcon, this.tag, this.bgColor, this.fontColor, this.useCustomFont=false});

  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      borderColor: fontColor??ktransparent,
      color: bgColor ?? ktertiary,
      radius: 50,
      vpad: 3,
      hpad: 3,
      widget: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              tagIcon ?? Assets.imagesTags,
              color: fontColor ?? kwhite,
              width: 12,
              height: 12,
            ),
            Flexible(
              child: MyText(
                text: tag ?? "",
                size: 10,
                color: fontColor ?? kwhite,
                paddingLeft: 3,
                textOverflow: TextOverflow.ellipsis,
                maxLines: 1,
                useCustomFont: useCustomFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
