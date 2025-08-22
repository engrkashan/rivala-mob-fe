import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rivala/controllers/font_controller.dart';
import 'package:rivala/controllers/image_picker_controller.dart';
import 'package:rivala/controllers/navbar_controller.dart';
import 'package:rivala/font_customisation/font_customization.dart';
import 'package:rivala/view/screens/master_flow/auth/signIn/signin.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
   

  Get.put(ThemeController());
  Get.put(BottomNavBarController());
  Get.put(ImagePickerController());
  Get.put(FontController());
  runApp(const MyApp());
}

final String dummyImage2 =
    'https://plus.unsplash.com/premium_photo-1661766718556-13c2efac1388?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9jdG9yc3xlbnwwfHwwfHx8MA%3D%3D';

final String dummyImage =
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, home: MasterSignIn());
  }
}
