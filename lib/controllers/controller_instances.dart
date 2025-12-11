import 'package:get/get.dart';
import 'package:rivala/controllers/navbar_controller.dart';

// Use getter instead of global variable to avoid initialization race condition
BottomNavBarController get navBarController =>
    Get.find<BottomNavBarController>();
