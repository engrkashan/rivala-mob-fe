import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/create_links.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/link_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

class MasterChooseTheme extends StatefulWidget {
  const MasterChooseTheme({super.key});

  @override
  State<MasterChooseTheme> createState() => _MasterChooseThemeState();
}

class _MasterChooseThemeState extends State<MasterChooseTheme> {
  List<Color> selectedColors = List.filled(5, Colors.black);
  List<TextEditingController> colorControllers =
      List.generate(5, (index) => TextEditingController(text: "#000000"));

  void _openColorPicker(int index) {
    Color tempColor = selectedColors[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  selectedColors[index] = tempColor;
                  colorControllers[index].text =
                      '#${tempColor.value.toRadixString(16).substring(2).toUpperCase()}';
                });
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
      appBar: simpleAppBar(
        context: context,
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
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(color: kgrey2),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                MyText(
                  text: 'Cover Image',
                  size: 16,
                  weight: FontWeight.w600,
                  color: kblack2,
                  paddingBottom: 20,
                ),
                theme_stack_image(height: 600, width: Get.width, isedit: true),
                const SizedBox(height: 30),
                MyText(
                  text: 'Color Palette',
                  size: 16,
                  weight: FontWeight.w600,
                  color: kblack2,
                  paddingBottom: 15,
                ),
                ...List.generate(
                    selectedColors.length,
                    (index) => Column(
                          children: [
                            color_palette_row("Header Color $index", index),
                            const SizedBox(height: 15),
                          ],
                        )),
                SizedBox(
                  height: 30,
                ),
                Mybutton2(
                  buttonText: 'Save',
                  mbot: 30,
                  ontap: () {
                    Get.to(() => GradientSuccessScreen(
                          title: 'Well done!',
                          desc: 'Now, let’s import your links.',
                          buttontext: 'Import your links',
                          ontap: () {
                            Get.to(() => MasterCreateLink());
                          },
                          skipTap: () {
                        MAsterLinkSuccess();
                          },
                        ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row color_palette_row(String title, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: MyText(
            text: title,
            color: ktertiary,
            size: 14,
          ),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            controller: colorControllers[index],
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: ktertiary),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: ktertiary),
              ),
              hintText: "#000000",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
              isDense: true,
            ),
            style: const TextStyle(color: Colors.black),
            onChanged: (value) {
              try {
                setState(() {
                  selectedColors[index] =
                      Color(int.parse(value.replaceFirst('#', '0xff')));
                });
              } catch (e) {
                selectedColors[index] = Colors.black;
              }
            },
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => _openColorPicker(index),
          child: color_picker(bgColor: selectedColors[index]),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
