import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rivala/consts/app_fonts.dart';

class ThemeController extends GetxController {
  // Default font
  var selectedFont = AppFonts.poppins.obs;

  void updateFont(String fontFamily) {
    selectedFont.value = fontFamily;
  }
}
