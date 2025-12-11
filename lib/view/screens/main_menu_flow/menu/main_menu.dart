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
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_row.dart';
import 'package:rivala/view/widgets/expanded_row.dart';
import 'package:rivala/view/widgets/main_menu_widgets/circle_icon.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/providers/user/auth_provider.dart';
import '../../../../view/widgets/common_image_view_widget.dart';

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
                    MyText(
                      text: 'Terms of Services',
                      size: 10,
                      color: kblack,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(width: 47),
                    MyText(
                      text: 'Privacy Policy',
                      size: 10,
                      color: kblack,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                MyText(
                  paddingTop: 20,
                  textAlign: TextAlign.center,
                  text: 'Set Theme',
                  weight: FontWeight.w500,
                  size: 10,
                  color: Color(0xffD2468D),
                  paddingBottom: 100,
                ),
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
