import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/controllers/image_picker_controller.dart';
import 'package:rivala/view/screens/discovery/social_commerce_hub.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/messaging/connection_mesg.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/main_menu.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_details.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/main_profile.dart';
import 'package:rivala/view/widgets/image_picker_bottom_sheet.dart';
import 'package:rivala/view/widgets/image_picker_bottom_sheet_2.dart';

const posts = '/posts';
const chats = '/chats';
const discover = '/discover';
const storeMenu = '/storeMenu';
const mainMenu = '/mainMenu';
final navigatorKeys = {
  posts: GlobalKey<NavigatorState>(),
  chats: GlobalKey<NavigatorState>(),
  discover: GlobalKey<NavigatorState>(),
  storeMenu: GlobalKey<NavigatorState>(),
  mainMenu: GlobalKey<NavigatorState>(),
};
void resetNavigatorKeys() {
  navigatorKeys[posts] = GlobalKey<NavigatorState>();
  navigatorKeys[chats] = GlobalKey<NavigatorState>();
  navigatorKeys[discover] = GlobalKey<NavigatorState>();
  navigatorKeys[storeMenu] = GlobalKey<NavigatorState>();
  navigatorKeys[mainMenu] = GlobalKey<NavigatorState>();
}

class BottomNavBarController extends GetxController {
  static final BottomNavBarController instance =
      Get.find<BottomNavBarController>();
  final controller = Get.put(ImagePickerController());
  RxBool isHide = false.obs;
  void onHide() {
    isHide.value = !isHide.value;
  }

  // static const COMMUNITY = '/community';
  // static const FAST = '/fast';
  // static const posts = '/posts';
  // static const MEDITATION = '/meditation';
  // static const ASKAI = '/ask_ai';
  RxInt currentIndex = 2.obs;
  RxString currentRoute = discover.obs;
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    posts: GlobalKey<NavigatorState>(),
    chats: GlobalKey<NavigatorState>(),
    discover: GlobalKey<NavigatorState>(),
    storeMenu: GlobalKey<NavigatorState>(),
    mainMenu: GlobalKey<NavigatorState>(),
  };
  void resetNavigatorKeys() {
    navigatorKeys[posts] = GlobalKey<NavigatorState>();
    navigatorKeys[chats] = GlobalKey<NavigatorState>();
    navigatorKeys[discover] = GlobalKey<NavigatorState>();
    navigatorKeys[storeMenu] = GlobalKey<NavigatorState>();
    navigatorKeys[mainMenu] = GlobalKey<NavigatorState>();
  }

  List<String> pageRoutes = [posts, chats, discover, storeMenu, mainMenu];
  void getCurrentScreen(
      String currentPage, int index, BuildContext context) async {
    try {
      if (index == 0) {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          elevation: 0,
          builder: (_) {
            return ImagePickerBottomSheet(
              onCameraPick: () async {
                Get.back();
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  builder: (_) {
                    return ImagePickerBottomSheet2(
                      onCameraPick: () async {
                        Get.back();
                        controller.pickImageFromCamera();
                      },
                      onGalleryPick: () async {
                        Get.back();
                        controller.pickMultipleMedia();
                      },
                    );
                  },
                );
              },
              onGalleryPick: () async {
                Get.back();
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  builder: (_) {
                    return ImagePickerBottomSheet2(
                      onCameraPick: () async {
                        Get.back();
                        controller.pickVideoAndGenerateThumbnail(
                            fromCamera: true);
                      },
                      onGalleryPick: () async {
                        Get.back();
                        controller.pickVideoAndGenerateThumbnail(
                            fromCamera: false);
                      },
                    );
                  },
                );
              },
            );
          },
        );
        return;
      }

      if (currentPage == currentRoute.value) {
        navigatorKeys[currentPage]!.currentState!.popUntil(
              (route) => route.isFirst,
            );
      } else {
        currentIndex.value = index;
        currentRoute.value = pageRoutes[index];
      }

      update();
    } catch (e) {
      log("Error in navigation: $e");
      // Optionally show an error dialog or message to the user
    }
  }

  // Future<void> handlePageChange(int index) async {
  //   if (index == 2) {
  //     showLoadingDialog(); // Assuming this function encapsulates the dialog logic
  //     try {
  //       await OrdersRepo().getCurrentUsersOrders();
  //     } finally {
  // //       closeLoadingDialog(); // Make sure to close the dialog regardless of success or failure
  // //     }
  // //   }
  // // }
  // void showLoadingDialog() {
  //   DialogService.instance.showProgressDialog(context: Get.context!);
  // }
  // void closeLoadingDialog() {
  //   Get.back();
  // }
  Widget buildOffStageNavigator(String page) {
    return Obx(
      () => Offstage(
        offstage: currentRoute.value != page,
        child: PageNavigator(
          navigatorKey: navigatorKeys[page]!,
          page: page,
        ),
      ),
    );
  }

  Future<bool> onBackTap(BuildContext context) async {
    final NavigatorState? currentState =
        navigatorKeys[currentRoute.value]?.currentState;

    if (currentState != null && currentState.canPop()) {
      currentState.pop();
      return false;
    } else {
      if (currentIndex.value != 2) {
        getCurrentScreen(discover, 2, context);
        return false;
      }
    }

    return true;
  }
}

class PageNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String page;
  const PageNavigator({
    Key? key,
    required this.navigatorKey,
    required this.page,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (page == posts)
      child = GradientSuccessScreen(
        hasSkip: false,
      ); // this will never be shown now, since we use Get.to for posts
    else if (page == chats)
      child = ConnectionMesg(hasBack: false);
    else if (page == discover)
      child = SocialCommerceHub();
    else if (page == storeMenu)
      child = const StoreMainProfile();
    else if (page == mainMenu)
      child = const MainMenu();
    else
      child = PostDetails(); // fallback
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => child!);
      },
    );
  }
}
