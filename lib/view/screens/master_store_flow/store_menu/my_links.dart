import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/providers/brands_provider.dart';

class MyLinks extends StatefulWidget {
  const MyLinks({super.key});

  @override
  State<MyLinks> createState() => _MyLinksState();
}

class _MyLinksState extends State<MyLinks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kheader,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 22),
                  child: Bounce_widget(
                      ontap: () {
                        Navigator.pop(context);
                      },
                      widget: Image.asset(
                        Assets.imagesBackicon2,
                        width: 46,
                        height: 46,
                      )),
                )),
            Expanded(
                child: Consumer<BrandsProvider>(builder: (context, ref, _) {
              final links = ref.currentStore?.links;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: links?.length ?? 0,
                  itemBuilder: (context, i) {
                    return Column(children: [
                      links_button(
                          icon: links?[i].url, title: "${links?[i].name}")
                    ]);
                  });
              //   return  ListView(
              //   shrinkWrap: true,
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              //   physics: const BouncingScrollPhysics(),
              //   children: [
              //     Image.asset(
              //       Assets.imagesStorelogo,
              //       height: 95,
              //       width: 240,
              //       fit: BoxFit.contain,
              //       color: kblack,
              //     ),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     links_button(),
              //     SizedBox(
              //       height: 15,
              //     ),
              //     links_button(
              //       title: 'Facebook',
              //       icon: Assets.imagesFacebook,
              //     ),
              //     SizedBox(
              //       height: 15,
              //     ),
              //     links_button(
              //       title: 'TikTok',
              //       icon: Assets.imagesTiktok,
              //     ),
              //     SizedBox(
              //       height: 15,
              //     ),
              //     links_button(
              //       title: 'apolloandsage.com',
              //       icon: Assets.imagesProfileicon,
              //     )
              //   ],
              // );
            })),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
              child: Store_Button_Row(),
            ),
          ],
        ));
  }
}

class links_button extends StatelessWidget {
  final String? title, icon;
  final VoidCallback? ontap;
  const links_button({
    super.key,
    this.title,
    this.icon,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap,
      widget: CustomeContainer(
        color: kblack,
        radius: 50,
        vpad: 8,
        hpad: 8,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              icon ?? "",
              width: 27,
              height: 27,
            ),
            Expanded(
                child: Center(
              child: MyText(
                text: title ?? 'Instagram',
                size: 15,
                weight: FontWeight.w600,
                color: kwhite,
                useCustomFont: true,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
