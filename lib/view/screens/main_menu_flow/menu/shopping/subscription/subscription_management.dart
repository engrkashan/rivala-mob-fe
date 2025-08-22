import 'package:flutter/material.dart';

import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/subscription_manage_widget.dart';

class SubscriptionManagement extends StatefulWidget {
  const SubscriptionManagement({super.key});

  @override
  State<SubscriptionManagement> createState() => _SubscriptionManagementState();
}

class _SubscriptionManagementState extends State<SubscriptionManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,
            title: 'Subscription Management', size: 15, centerTitle: true),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: subscription_management_container(
                          delay: (index + 1) * 200,
                          //showContainer: index == 0 ? true : false,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
