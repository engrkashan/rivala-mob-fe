// utils/color_utils.dart
import 'package:flutter/material.dart';

extension HexColor on String {
  Color toColor() {
    String hex = replaceAll("#", "").trim();
    if (hex.length == 6) {
      hex = "FF$hex"; // Add full opacity
    }
    return Color(int.parse("0x$hex"));
  }
}
