import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../controllers/providers/post_provider.dart';
import '../../../../../models/collection_model.dart';

class TagCollection extends StatefulWidget {
  const TagCollection({super.key});

  @override
  State<TagCollection> createState() => _TagCollectionState();
}

class _TagCollectionState extends State<TagCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Tag collections',
            centerTitle: true,
            actions: [
              // Bounce_widget(
              //     ontap: () {
              //       Get.to(() => CreateCollection());
              //     },
              //     widget: MyText(
              //       text: '+ New',
              //       size: 16,
              //       color: kblue,
              //       weight: FontWeight.w500,
              //     )),
              // SizedBox(
              //   width: 12,
              // )
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: kgrey2,
            ),
            Expanded(child: Consumer<CollectionProvider>(
              builder: (context, ref, _) {
                final collection = ref.allCollections;
                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: MyTextField(
                        radius: 50,
                        filledColor: kgrey4,
                        hint: 'Search your collections . . .',
                        bordercolor: ktransparent,
                        suffixIcon: Image.asset(
                          Assets.imagesSearch,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (collection.isEmpty)
                      Center(child: MyText(text: "No Collections Available")),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: collection.length,
                      itemBuilder: (context, switchIndex) {
                        final col = collection[switchIndex];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: icon_text_row(
                            collection: col,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            )),
            Mybutton2(
              buttonText2: 'Cancel',
              buttonText: 'Done',
              mbot: 30,
              hpad: 22,
              ontap: () {
                Get.back();
              },
              ontap2: () {
                Get.back();
              },
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        context.read<CollectionProvider>().loadAllCollections();
      });
    });
  }
}

class icon_text_row extends StatefulWidget {
  final Color? bgColor;
  final String? title, icon;
  final bool? hasIcon, useCustomFont;
  final FontWeight? weight;
  final double? textSize;
  final CollectionModel? collection;
  const icon_text_row({
    super.key,
    this.bgColor,
    this.title,
    this.icon,
    this.hasIcon = true,
    this.textSize,
    this.weight,
    this.useCustomFont = false,
    this.collection,
  });

  @override
  State<icon_text_row> createState() => _icon_text_rowState();
}

class _icon_text_rowState extends State<icon_text_row> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
        ontap: () {
          setState(() {
            isSelected = !isSelected;
          });
          if (isSelected) {
            Provider.of<PostProvider>(context, listen: false)
                .tagCollections
                .add(widget.collection ?? CollectionModel());
          } else {
            Provider.of<PostProvider>(context, listen: false)
                .tagCollections
                .remove(widget.collection ?? CollectionModel());
          }
        },
        widget: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected ? widget.bgColor ?? kbackground : ktransparent,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: 22, vertical: isSelected ? 8 : 0),
          child: Row(
            children: [
              if (widget.hasIcon == true)
                Image.asset(
                  widget.icon ?? Assets.imagesCollection2,
                  width: 21,
                  height: 21,
                ),
              Expanded(
                  child: MyText(
                text: widget.collection?.name ?? widget.title ?? 'Apparel',
                size: widget.textSize ?? 16,
                color: kblack,
                weight: widget.weight,
                useCustomFont: widget.useCustomFont,
                paddingLeft: widget.hasIcon == true ? 18 : 0,
              )),
              CustomCheckBox(
                isActive: isSelected ? true : false,
                onTap: () {},
                borderColor: kblack,
                iscircle: true,
                circleIcon: Icons.check,
              )
            ],
          ),
        ));
  }
}
