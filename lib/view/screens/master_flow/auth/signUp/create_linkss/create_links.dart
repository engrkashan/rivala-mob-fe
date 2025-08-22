import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/import_linktree/import_linktree_email.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/link_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/indiviual_link.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/dotted_border_container.dart';
import 'package:rivala/view/widgets/my_button.dart';

class MasterCreateLink extends StatefulWidget {
  const MasterCreateLink({super.key});

  @override
  State<MasterCreateLink> createState() => _MasterCreateLinkState();
}

class _MasterCreateLinkState extends State<MasterCreateLink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Add Your Links',
            centerTitle: true,
            actions: [
              Bounce_widget(
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
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                physics: const BouncingScrollPhysics(),
                children: [
                  DottedBorderContainer(
                    icon: Assets.imagesLinktree,
                    ontap: () {
                      Get.to(() => ImportLinktreeEmail());
                    },
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  DottedBorderContainer(
                    ontap: () {
                      Get.to(() => IndiviualLink());
                    },
                    vpad: 25,
                    title: '+ Manually add new links',
                  ),
                ],
              ),
            ),
            MyButton(
              buttonText: 'Done with links',
              mBottom: 60,
              mhoriz: 30,
              onTap: () {
                Get.to(() => MAsterLinkSuccess());
              },
            )
          ],
        ));
  }
}
