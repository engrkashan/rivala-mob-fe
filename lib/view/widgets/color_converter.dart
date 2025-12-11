import 'package:flutter/material.dart';

/// Converts a hex color string to a [Color] object.
///
/// [hexString] can be in the form "#RRGGBB" or "RRGGBB".
/// Optionally, you can include alpha as "#AARRGGBB".
Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7)
    buffer.write('ff'); // add alpha if missing
  hexString = hexString.replaceFirst('#', '');
  buffer.write(hexString);
  return Color(int.parse(buffer.toString(), radix: 16));
}

String colorToHex(Color color) {
  // Remove alpha channel
  return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
}
