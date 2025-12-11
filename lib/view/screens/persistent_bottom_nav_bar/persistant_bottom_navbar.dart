import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/controller_instances.dart';
import 'package:rivala/controllers/navbar_controller.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';

class PersistentBottomNavBar extends StatefulWidget {
  const PersistentBottomNavBar({super.key});

  @override
  State<PersistentBottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<PersistentBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // showCaseController.initShowCase(context);
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  @override
  void dispose() {
    //_pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _items = [
    {
      'label': 'post',
      'icon': Assets.imagesAddpost,
    },
    {
      'label': 'Chat',
      'icon': Assets.imagesChat,
    },
    {
      'label': 'discovery',
      'icon': Assets.imagesChat,
    },
    {'label': 'storemenu', 'icon': Assets.imagesProfileicon, 'width': 47},
    {
      'label': 'mainmenu',
      'icon': Assets.imagesMenuu,
    },
  ];

  final empty1 = GlobalKey();

  final empty2 = GlobalKey();

  final empty3 = GlobalKey();

  final empty4 = GlobalKey();
  final empty5 = GlobalKey();

  bool isAlertDialogueVisible = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop) {
          await navBarController.onBackTap(context);
        }
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            navBarController.buildOffStageNavigator(posts),
            navBarController.buildOffStageNavigator(
              chats,
            ),
            navBarController.buildOffStageNavigator(
              discover,
            ),
            navBarController.buildOffStageNavigator(
              storeMenu,
            ),
            navBarController.buildOffStageNavigator(
              mainMenu,
            ),
          ],
        ),
        bottomNavigationBar: _BuildBottomNavBar(),
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FixedCenterDockedFabLocation(),
      ),
    );
  }

  Obx _BuildBottomNavBar() {
    return Obx(
      () {
        return Container(
          height: Platform.isIOS ? null : 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: kblack2.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, -1),
              ),
            ],
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(35),
            //     topRight: Radius.circular(35))
          ),
          child: BottomAppBar(
            elevation: 0,
            color: kwhite,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(
                      0,
                    ),
                    _buildNavItem(
                      1,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    _buildNavItem(3),
                    _buildNavItem(
                      4,
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index, {double? width}) {
    if (index == 2) return const SizedBox(); // FAB handles Discovery

    bool isSelected = navBarController.currentIndex.value == index;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5, left: 5),
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonImageView(
              imagePath: _items[index]['icon'],
              width: width ?? 25,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    navBarController.getCurrentScreen(
        navBarController.pageRoutes[index], index, context);
  }

  Widget _buildFloatingActionButton() {
    return Bounce_widget(
      ontap: () {
        _onItemTapped(2);
      },
      widget: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Image.asset(
            height: 90,
            // fit: BoxFit.contain,
            // width: 100,
            navBarController.currentIndex.value == 2
                ? Assets.imagesDiscover
                : Assets.imagesDiscover),
      ),
    );
  }
}

class FixedCenterDockedFabLocation extends StandardFabLocation
    with FabCenterOffsetX, FabDockedOffsetY {
  const FixedCenterDockedFabLocation();
  @override
  String toString() => 'FloatingActionButtonLocation.fixedCenterDocked';
  @override
  double getOffsetY(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double bottomDistance =
        WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomDistance > 0) {
      // Keyboard is visible, return an offset to move the FAB above the keyboard
      return -bottomDistance;
    }
    // Keyboard is not visible, return the default offset
    return super.getOffsetY(scaffoldGeometry, adjustment);
  }
}
