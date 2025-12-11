import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/media_provider.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/customize_theme_grad_screen.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/color_converter.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../controllers/providers/theme_provider.dart';
import '../../../../../generated/assets.dart';
import '../../../../../models/theme_model.dart';

class SelectTheme extends StatefulWidget {
  final String? title, buttonText;
  final VoidCallback? buttonTap;
  const SelectTheme({super.key, this.title, this.buttonText, this.buttonTap});

  @override
  State<SelectTheme> createState() => _SelectThemeState();
}

class _SelectThemeState extends State<SelectTheme> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ThemeProvider>().loadAllThemes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context,
          title: widget.title ?? 'Select Your Theme',
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
            child: Consumer<ThemeProvider>(
              builder: (context, theme, _) {
                final themes = theme.themes;
                if (themes.isEmpty) {
                  return Center(
                      child:
                          Text("No themes available")); // or a loading widget
                }
                if (theme.isLoading) {
                  return CircularProgressIndicator();
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 300),
                        height: Get.height,
                        enlargeFactor: 0.1,
                        viewportFraction: 0.7,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      itemCount: themes.length,
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              MyText(
                                text: themes[index].name ?? "",
                                size: 16,
                                weight: FontWeight.w600,
                                color: kblack2,
                                paddingBottom: 20,
                              ),
                              theme_stack_image(
                                theme: themes[index],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  color_picker(),
                                  SizedBox(width: 8),
                                  color_picker(
                                      bgColor: hexToColor(
                                          themes[index].color1 ?? "")),
                                  SizedBox(width: 8),
                                  color_picker(
                                      bgColor: hexToColor(
                                          themes[index].color2 ?? "")),
                                  SizedBox(width: 8),
                                  color_picker(
                                      bgColor: hexToColor(
                                          themes[index].color2 ?? "")),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Mybutton2(
        buttonText: widget.buttonText ?? 'Next',
        ontap: widget.buttonTap ??
            () {
              Get.to(() => CustomizeThemeGradScreen());
            },
        mbot: 30,
        hpad: 22,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class theme_stack_image extends StatelessWidget {
  final String? title, desc, image;
  final double? height, width;
  final bool? isedit;
  final ThemeModel? theme;
  const theme_stack_image({
    super.key,
    this.title,
    this.desc,
    this.image,
    this.height,
    this.width,
    this.isedit = false,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: isedit == false
                  ? [
                      BoxShadow(
                        color: kblack.withOpacity(0.25),
                        blurRadius: 6,
                        spreadRadius: 6,
                        offset: Offset(4, 4),
                      ),
                    ]
                  : []),
          child: CommonImageView(
            url: theme?.coverImage,
            imagePath: theme?.coverImage ?? Assets.imagesDummyImg,
            file: context.read<MediaProvider>().selectedImage,
            height: height ?? 400,
            width: width ?? 250,
            radius: 15,
          ),
        ),
        Positioned(
          top: 20,
          child: Column(
            children: [
              MyText(
                text: theme?.name ?? 'Headline',
                color: kwhite,
                size: 32,
                weight: FontWeight.bold,
                paddingBottom: 5,
              ),
              MyText(
                text: theme?.bodyFont ?? 'Subheader',
                color: kwhite,
                size: 16,
                weight: FontWeight.w400,
                paddingBottom: 8,
              ),
            ],
          ),
        ),
        if (isedit == true)
          Positioned(
              bottom: 10,
              right: 10,
              child: Bounce_widget(
                  ontap: () async {
                    await context.read<MediaProvider>().pickImage();
                    await context.read<MediaProvider>().upload();
                  },
                  widget: Image.asset(
                    Assets.imagesEdit3,
                    width: 39,
                    height: 39,
                  )))
      ],
    );
  }
}

class color_picker extends StatelessWidget {
  final bool? showShadow;
  final Color? bgColor;
  final double? size;
  final VoidCallback? ontapp;
  const color_picker(
      {super.key,
      this.bgColor,
      this.showShadow = true,
      this.size,
      this.ontapp});

  @override
  Widget build(BuildContext context) {
    RxBool isSelected = false.obs;
    return Obx(
      () => Bounce_widget(
        ontap: ontapp ??
            () {
              isSelected.value = !isSelected.value;
            },
        widget: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: isSelected.value == true ? kblack : ktransparent,
                  width: 2.5)),
          padding: EdgeInsets.all(2.5),
          child: Container(
            width: size ?? 32,
            height: size ?? 32,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor ?? kwhite,
                boxShadow: showShadow == true
                    ? [
                        BoxShadow(
                          color: kblack.withOpacity(0.25),
                          blurRadius: 6,
                          spreadRadius: 4,
                          offset: Offset(4, 4),
                        ),
                      ]
                    : []),
          ),
        ),
      ),
    );
  }
}
