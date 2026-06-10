import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/connections/your_connections.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/manage_store/manage_store.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/sell_on_rivala/sell_on_rivala.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/shopping/shopping.dart';
import 'package:rivala/view/screens/main_menu_flow/menu/wallet/wallet_main.dart';
import 'package:rivala/view/screens/master_flow/auth/terms_conditions.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/providers/user/auth_provider.dart';
import '../../../../view/widgets/common_image_view_widget.dart';
import '../../master_flow/auth/privay_policy.dart';
import '../../master_flow/auth/signIn/signin.dart';
import '../../master_flow/auth/signUp/customize_theme.dart';
import '../../master_flow/auth/signUp/select_theme.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> mainMenuItems = [
      {
        'text1': 'Shopping',
        'text2': 'Effortlessly manage your purchases and subscriptions.',
        'icon': Assets.imagesBag,
        'delay': 100,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(page: Shopping()),
            )
        //  Get.to(
        //       () => Shopping(),
        //       transition: Transition.downToUp,
        //       duration: const Duration(milliseconds: 1000),
        //       curve: Curves.easeInOut,
        //     ),
      },
      {
        'text1': 'Your Connections',
        'text2':
            'Join your friends & embrace the power of community as a squad.',
        'icon': Assets.imagesConnections,
        'delay': 250,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(page: YourConnections()),
            )
        //  Get.to(
        //       () => YourConnections(),
        //       transition: Transition.downToUp,
        //       duration: const Duration(milliseconds: 1000),
        //       curve: Curves.easeInOut,
        //     ),
      },
      {
        'text1': 'Manage Your Store',
        'text2':
            'Manage your own store of posts and products simply and easily!',
        'icon': Assets.imagesManageStore,
        'delay': 400,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(page: ManageStore()),
            )
        // Get.to(() => ManageStore()),
      },
      {
        'text1': 'Sell on Rivala',
        'text2': 'Manage products and orders with ease & boost your sales.',
        'icon': Assets.imagesSell,
        'delay': 550,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(page: SellOnRivala()),
            )
        //Get.to(() => SellOnRivala()),
      },
      {
        'text1': 'Wallet',
        'text2': 'See your earnings and get paid on Rivala.',
        'icon': Assets.imagesWallet,
        'delay': 700,
        'ontap': () => Navigator.of(context).push(
              CustomPageRoute(page: WalletMain()),
            )
        //Get.to(() => WalletMain()),
      },
    ];
    return Scaffold(
      backgroundColor: kwhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<AuthProvider>(
              builder: (context, auth, _) {
                final user = auth.user;
                return Row(
                  children: [
                    Bounce_widget(
                        widget: Image.asset(
                      Assets.imagesBellIcon,
                      width: 25,
                      height: 25,
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                      child: row_widget(
                        onTap: () {
                          // Navigate to profile?
                        },
                        title: user?.name != null
                            ? '@${user!.username ?? user.name}'
                            : '@User',
                        textColor: kdargrey,
                        iconData: Icons.keyboard_arrow_down_rounded,
                        isIconRight: true,
                      ),
                    ),
                    if (user?.avatarUrl != null)
                      CommonImageView(
                        url: user!.avatarUrl!,
                        height: 40,
                        width: 40,
                        radius: 50,
                        fit: BoxFit.cover,
                      )
                    else
                      circular_icon_container() // Fallback
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              physics: const BouncingScrollPhysics(),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  physics: const BouncingScrollPhysics(),
                  itemCount: mainMenuItems.length,
                  itemBuilder: (context, index) {
                    final item = mainMenuItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MainMenuRow(
                        text1: item['text1'],
                        text2: item['text2'],
                        icon: item['icon'],
                        delay: item['delay'],
                        isSelected: selectedIndex == index,
                        ontap: () {
                          setState(() {
                            selectedIndex = index;
                          });

                          Future.delayed(const Duration(milliseconds: 300), () {
                            item['ontap']();
                          });
                        },
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Bounce_widget(
                      ontap: () {
                        Get.to(() => const TermsConditions());
                      },
                      widget: MyText(
                        text: 'Terms of Services',
                        size: 10,
                        color: kblack,
                        weight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 47),
                    Bounce_widget(
                      ontap: () => Get.to(() => const PrivacyPolicy()),
                      widget: MyText(
                        text: 'Privacy Policy',
                        size: 10,
                        color: kblack,
                        weight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                Bounce_widget(
                  ontap: () {
                    Get.to(() => const CustomizeTheme());
                  },
                  widget: MyText(
                    paddingTop: 20,
                    textAlign: TextAlign.center,
                    text: 'Set Theme',
                    weight: FontWeight.w500,
                    size: 10,
                    color: const Color(0xffD2468D),
                  ),
                ),
                const SizedBox(height: 10),
                Bounce_widget(
                  ontap: () {
                    // Confirmation Dialog
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: kwhite,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              const Icon(Icons.logout_rounded, color: Colors.red, size: 50),
                              const SizedBox(height: 20),

                              MyText(
                                text: "Logout Confirmation",
                                size: 20,
                                weight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 10),

                              MyText(
                                text: "Are you sure you want to sign out of your account?",
                                size: 14,
                                color: ktertiary,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),

                              Row(
                                children: [
                                  // Cancel Button
                                  Expanded(
                                    child: Bounce_widget(
                                      ontap: () => Get.back(),
                                      widget: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        decoration: BoxDecoration(
                                          color: ktertiary.withOpacity(0.1), // Subtle color
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(child: MyText(text: "Cancel", color: kblack, weight: FontWeight.w600)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),


                                  Expanded(
                                    child: Bounce_widget(
                                      ontap: () async {
                                        Get.back();
                                        await context.read<AuthProvider>().logout();
                                       // Get.offAll(() => const MasterSignIn());
                                      },
                                      widget: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        decoration: BoxDecoration(
                                          gradient: kgradmainmenu,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child:   Center(
                                          child: MyText(
                                            text: "Logout",
                                            color: Colors.white, // kwhite
                                            weight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  widget: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.red, size: 20),
                        SizedBox(width: 10),
                        MyText(
                          text: 'Logout',
                          color: Colors.red,
                          weight: FontWeight.w600,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainMenuRow extends StatelessWidget {
  final String? icon, text1, text2;
  final VoidCallback? ontap;
  final int? delay;
  final bool isSelected;

  const MainMenuRow({
    super.key,
    this.icon,
    this.text1,
    this.text2,
    this.ontap,
    this.delay,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: ontap,
      widget: Animate(
        effects: [MoveEffect(delay: Duration(milliseconds: delay ?? 100))],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            gradient: isSelected ? kgradmainmenu : null,
          ),
          margin: EdgeInsets.only(left: 20, right: isSelected ? 0 : 20),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              circular_icon_container(
                icon: icon,
                iconColor: isSelected ? kwhite : kblue2,
                bgColor: isSelected
                    ? kwhite.withOpacity(0.09)
                    : kmenuGreen.withOpacity(0.1),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TwoTextedColumn(
                  text1: text1 ?? 'Shopping',
                  text2: text2 ??
                      'Effortlessly manage your purchases and subscriptions.',
                  color1: isSelected ? kwhite : kblack,
                  color2: isSelected ? kwhite : ktertiary,
                  weight1: FontWeight.bold,
                  weight2: FontWeight.normal,
                  size1: 18,
                  size2: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
