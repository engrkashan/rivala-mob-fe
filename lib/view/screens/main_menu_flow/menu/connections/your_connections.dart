import 'package:flutter/material.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/followers_manual_add.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/following_manual_add.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/connection_mesg.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import 'squads/squads.dart';

class YourConnections extends StatefulWidget {
  const YourConnections({super.key});

  @override
  State<YourConnections> createState() => _YourConnectionsState();
}

class _YourConnectionsState extends State<YourConnections> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> mainMenuItems = [
      {
        'textt': 'Followers',
        'icon': Assets.imagesFollower,
        'delay': 100,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(
                  page: FollowersManualAdd(
                title: 'Followers',
                follower: true,
                hintText: 'Search followers',
              )),
            )
        // Get.to(
        //       () => FollowersManualAdd(),
        //       transition: Transition.downToUp,
        //       duration: const Duration(milliseconds: 1000),
        //       curve: Curves.easeInOut,
        //     ),
      },
      {
        'textt': 'Following',
        'icon': Assets.imagesFollowing,
        'delay': 250,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(page: FollowingsManualAdd()),
            )
      },
      {
        'textt': 'Squads',
        'icon': Assets.imagesSquad,
        'delay': 400,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(page: Squads()),
            )
      },
      {
        'textt': 'Messages',
        'icon': Assets.imagesMesg,
        'delay': 550,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(page: ConnectionMesg()),
            )
      },
    ];
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context, actions: [
          circular_icon_container(),
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
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  MyText(
                    text: 'Your Connections',
                    size: 28,
                    weight: FontWeight.bold,
                    color: kblack,
                    paddingLeft: 22,
                    paddingBottom: 30,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    physics: const BouncingScrollPhysics(),
                    itemCount: mainMenuItems.length,
                    itemBuilder: (context, index) {
                      final item = mainMenuItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ShoppingRow(
                          textt: item['textt'],
                          icon: item['icon'],
                          delay: item['delay'],
                          isSelected: selectedIndex == index,
                          ontap: () {
                            setState(() {
                              selectedIndex = index;
                            });

                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              item['ontap']();
                            });
                          },
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
