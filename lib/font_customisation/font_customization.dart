import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



final FontController fontController=FontController()
;
class FontController extends GetxController {
   var selectedFont = ''.obs; // Holds the currently selected font
    var fontLoaded = false.obs; 
  void selectFont(String fontFamily) {
    selectedFont.value = fontFamily; // Update selected font globally

    log("Selected font: $selectedFont");
  }

  final Map<String, List<String>> fontFamilies = {
    'Montserrat': [
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742540084/Montserrat-SemiBold_na6kgx.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742540083/Montserrat-Regular_cpmbxc.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742540083/Montserrat-Medium_rs9wz6.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742540082/Montserrat-ExtraBold_r4jwo3.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742540080/Montserrat-Bold_j2xixs.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742540081/Montserrat-VariableFont_wght_yjcdia.ttf',
    ],
    'PlayfairDisplay': [
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742539083/PlayfairDisplay-SemiBold_zu1pft.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742539083/PlayfairDisplay-Medium_shyvym.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742539082/PlayfairDisplay-Regular_e7t7vt.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742539082/PlayfairDisplay-ExtraBold_dy1lqp.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742539082/PlayfairDisplay-Bold_awp4fv.ttf',
      'https://res.cloudinary.com/dczuun7n1/raw/upload/v1742539244/PlayfairDisplay-VariableFont_wght_yfbxn3.ttf',
    ],
  };

  Future<void> loadFonts(String fontName) async {
    try {
      if (!fontFamilies.containsKey(fontName)) return;

      for (String url in fontFamilies[fontName]!) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final fontLoader = FontLoader(fontName);
          fontLoader.addFont(Future.value(ByteData.sublistView(response.bodyBytes)));
          await fontLoader.load();

          log("Font loaded");
        } else {
          print('lalalalalalaaaaaaa');
        }
      }
      fontLoaded.value = true;
      selectedFont.value = fontName;
    } catch (e) {
      print('Erroryryryr $e');
    }
  }
}



