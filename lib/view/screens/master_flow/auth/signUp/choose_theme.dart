import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/controllers/providers/theme_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/theme_model.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/create_links.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/link_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/discovery_matching/product_setup_success.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/select_theme.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/color_converter.dart' hide colorToHex;
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final brandsProvider = context.read<BrandsProvider>();
      final themeProvider = context.read<ThemeProvider>();

      // Try to find the current theme from all themes using themeId from store
      final store = brandsProvider.currentStore;
      if (store != null && store.themeId != null) {
        final currentTheme =
            themeProvider.themes.firstWhereOrNull((t) => t.id == store.themeId);
        if (currentTheme != null) {
          _initializeWithTheme(currentTheme);
        }
      }
    });
  }

  void _initializeWithTheme(ThemeModel theme) {
    setState(() {
      selectedColors[0] = hexToColor(theme.colorDark ?? "#000000");
      selectedColors[1] = hexToColor(theme.color1 ?? "#000000");
      selectedColors[2] = hexToColor(theme.color2 ?? "#000000");
      selectedColors[3] = hexToColor(theme.color3 ?? "#000000");
      selectedColors[4] = hexToColor(theme.colorLight ?? "#000000");

      for (int i = 0; i < 5; i++) {
        colorControllers[i].text = colorToHex(selectedColors[i]);
      }
    });
  }

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
                            color_palette_row(_getColorTitle(index), index),
                            const SizedBox(height: 15),
                          ],
                        )),
                SizedBox(
                  height: 30,
                ),
                Mybutton2(
                  buttonText: 'Save',
                  mbot: 30,
                  ontap: () async {
                    final themeProvider = context.read<ThemeProvider>();
                    final brandsProvider = context.read<BrandsProvider>();

                    final newTheme =
                        await themeProvider.addCustomTheme(ThemeModel(
                      colorDark: colorToHex(selectedColors[0]),
                      color1: colorToHex(selectedColors[1]),
                      color2: colorToHex(selectedColors[2]),
                      color3: colorToHex(selectedColors[3]),
                      colorLight: colorToHex(selectedColors[4]),
                    ));

                    if (newTheme != null && newTheme.id != null) {
                      await themeProvider.attach(newTheme.id!);
                      await brandsProvider
                          .loadCurrentStore(); // Refresh store data (themeId)
                    }

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

  String _getColorTitle(int index) {
    switch (index) {
      case 0:
        return "Header Color";
      case 1:
        return "Subheader Color";
      case 2:
        return "Body Text Color";
      case 3:
        return "Button Color";
      case 4:
        return "Button Text Color";
      default:
        return "Color $index";
    }
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
                // Fallback handled by keeping current color
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
