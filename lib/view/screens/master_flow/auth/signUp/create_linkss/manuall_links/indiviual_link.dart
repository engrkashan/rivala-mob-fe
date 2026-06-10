import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/controllers/providers/link_provider.dart';
import 'package:rivala/controllers/providers/media_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/link_model.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/create_new_link.dart';
import 'package:rivala/view/widgets/animate_widgets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class IndiviualLink extends StatefulWidget {
  final LinkModel? link;
  const IndiviualLink({super.key, this.link});

  @override
  State<IndiviualLink> createState() => _IndiviualLinkState();
}

class _IndiviualLinkState extends State<IndiviualLink> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MediaProvider>().clearImage();
    });
  }

  final name = TextEditingController();
  final url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLink = widget.link != null;
    final link = widget.link;
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: isLink ? link?.name : "Create new link",
            centerTitle: true,
            actions: [
              Bounce_widget(
                  ontap: () {
                    Get.back();
                  },
                  widget: Image.asset(
                Assets.imagesClose,
                width: 18,
                height: 18,
              )),
              SizedBox(
                width: 12,
              )
            ]),
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
                  MyTextField(
                    controller: name,
                    hint: isLink ? link?.name : '',
                    label: 'Link Name',
                    hintColor: ktertiary,
                    delay: 200,
                    bordercolor: ktertiary,
                  ),
                  MyTextField(
                    controller: url,
                    hint: isLink ? link?.url : '',
                    label: 'URL',
                    delay: 400,
                    hintColor: ktertiary,
                    bordercolor: ktertiary,
                  ),
                  SlideAnimation(
                    delay: 600,
                    child: MyText(
                        text: 'Link Thumbnail',
                        size: 15,
                        paddingBottom: 8,
                        weight: FontWeight.w500,
                        color: kblack),
                  ),
                  Consumer<MediaProvider>(
                    builder: (context, media, _) {
                      return SlideAnimation(
                        delay: 700,
                        child: Bounce_widget(
                          ontap: () async {
                            await context.read<MediaProvider>().pickImage();
                          },
                          widget: CustomeContainer(
                            height: 188,
                            color: kgrey4,
                            radius: 15,
                            mtop: 0,
                            widget: media.selectedImage != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                media.selectedImage!,
                                width: double.infinity,
                                height: 188,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Center(
                              child: Image.asset(
                                Assets.imagesExportt,
                                width: 70,
                                height: 69,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (isLink)
                    SlideAnimation(
                      delay: 750,
                      child: MyText(
                          paddingTop: 30,
                          text: 'Remove link',
                          size: 15,
                          paddingBottom: 8,
                          weight: FontWeight.w400,
                          color: kred),
                    ),
                ],
              ),
            ),
            MyButton(
              buttonText: isLink ? "Update Link" : 'Save link',
              mBottom: 80,
              mhoriz: 35,
              onTap: () async {
                final media = context.read<MediaProvider>();

                if (media.selectedImage != null) {
                  await media.upload();
                }

                final uploadUrl = media.uploadedUrl;
                await context.read<BrandsProvider>().loadCurrentStore();
                final storeId = context.read<BrandsProvider>().currentStore?.id;

                if (!isLink) {
                  await context.read<LinkProvider>().setLink(
                    name.text,
                    url.text,
                    uploadUrl ?? "",
                    storeId!,
                  );
                }
                media.clearImage();
                Get.to(() => CreateNewLink());
              },
            ),
          ],
        ));
  }
}
