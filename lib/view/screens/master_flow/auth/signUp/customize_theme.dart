import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:rivala/config/routes.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/font_customisation/font_customization.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/create_links.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/main_profile.dart';
import 'package:rivala/view/screens/persistent_bottom_nav_bar/persistant_bottom_navbar.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/theme_selection_widget.dart';

class CustomizeTheme extends StatefulWidget {
  const CustomizeTheme({super.key});

  @override
  State<CustomizeTheme> createState() => _CustomizeThemeState();
}

class _CustomizeThemeState extends State<CustomizeTheme> {
  // Color kheader = kblack;
  // Color ksubHeader = Color(0xff610D3A);
  // Color kbody = Color(0xffD2468D);
  // Color kbutton = Color(0xff2E8DB8);
  // Color kbuttonText = Color(0xffFFFFFF);

  TextEditingController _kheaderController =
      TextEditingController(text: "#000000");
  TextEditingController _ksubHeaderController =
      TextEditingController(text: "#000000");
  TextEditingController _kbodyController =
      TextEditingController(text: "#000000");
  TextEditingController _kbuttonController =
      TextEditingController(text: "#000000");
  TextEditingController _kbuttonTextController =
      TextEditingController(text: "#000000");

  void _openColorPicker(
      {required Color currentColor, required Function(Color) onColorSelected}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                onColorSelected(color);
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(context: context,
            title: 'Customize Your Theme',
            centerTitle: true,
            actions: [
              Bounce_widget(
                widget: Image.asset(
                  Assets.imagesClose,
                  width: 18,
                  height: 18,
                ),
              ),
              SizedBox(width: 12),
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: kgrey2,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  MyText(
                    text: 'Cover Image',
                    size: 16,
                    weight: FontWeight.w600,
                    color: kblack2,
                    paddingBottom: 20,
                  ),
                  theme_stack_image(
                    height: 600,
                    width: Get.width,
                    isedit: true,
                  ),
                  SizedBox(height: 30),
                  MyText(
                    text: 'Color Palette',
                    size: 16,
                    weight: FontWeight.w600,
                    color: kblack2,
                    paddingBottom: 15,
                  ),
                  color_palette_row('Header Color', kheader, _kheaderController,
                      (color) {
                    setState(() {
                      kheader = color;
                      _kheaderController.text =
                          '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                    });
                  }),
                  SizedBox(height: 15),
                  color_palette_row(
                      'Sub header Color', ksubHeader, _ksubHeaderController,
                      (color) {
                    setState(() {
                      ksubHeader = color;
                      _ksubHeaderController.text =
                          '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                    });
                  }),
                  SizedBox(height: 15),
                  color_palette_row('Body Text Color', kbody, _kbodyController,
                      (color) {
                    setState(() {
                      kbody = color;
                      _kbodyController.text =
                          '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                    });
                  }),
                  SizedBox(height: 15),
                  color_palette_row('Button Color', kbutton, _kbuttonController,
                      (color) {
                    setState(() {
                      kbutton = color;
                      _kbuttonController.text =
                          '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                    });
                  }),
                  SizedBox(height: 15),
                  color_palette_row(
                      'Button Text Color', kbuttonText, _kbuttonTextController,
                      (color) {
                    setState(() {
                      kbuttonText = color;
                      _kbuttonTextController.text =
                          '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                    });
                  }),
                  SizedBox(
                    height: 40,
                  ),

                  ///FONT FAMILY

                  Fontselection(
                      title: 'Classic', fontFamily: 'PlayfairDisplay'),
                  SizedBox(height: 10),
                  Fontselection(title: 'Modern', fontFamily: 'Montserrat'),
                  SizedBox(height: 10),
                  Fontselection(title: 'Tech', fontFamily: 'Poppins'),

                  SizedBox(
                    height: 40,
                  ),
                  Mybutton2(
                    buttonText: 'Save',
                    mbot: 30,
                    ontap: () {
                          //Get.offAll(() => PersistentBottomNavBar());
                      Get.to(() => StoreMainProfile());
                      Get.to(() => GradientSuccessScreen(
                            title: 'Well done!',
                            desc: 'Now, let’s import your links.',
                            buttontext: 'Import your links',
                            ontap: () {
                              Get.to(() => MasterCreateLink());
                            },
                          ));
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Row color_palette_row(String title, Color color,
      TextEditingController controller, Function(Color) onColorChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: MyText(
              text: title,
              color: ktertiary,
              size: 14,
            )),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: ktertiary)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: ktertiary)),
                hintText: "#000000",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                isDense: true),
            style: TextStyle(color: kblack),
            onChanged: (value) {
              try {
                final newColor =
                    Color(int.parse(value.replaceFirst('#', '0xff')));
                onColorChanged(newColor);
              } catch (e) {
                // Fallback to the previous color if input is invalid
              }
            },
          ),
        ),
        SizedBox(width: 10),
        color_picker(
              bgColor: color,
              ontapp: ()=> _openColorPicker(
                currentColor: color, onColorSelected: onColorChanged),
            ),
        SizedBox(width: 16),
      ],
    );
  }
}
