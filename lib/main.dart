import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/session.dart';
import 'package:rivala/controllers/font_controller.dart';
import 'package:rivala/controllers/image_picker_controller.dart';
import 'package:rivala/controllers/navbar_controller.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/controllers/providers/chat_provider.dart';
import 'package:rivala/controllers/providers/link_provider.dart';
import 'package:rivala/controllers/providers/order_provider.dart';
import 'package:rivala/controllers/providers/post_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/controllers/providers/promo_provider.dart';
import 'package:rivala/controllers/providers/theme_provider.dart';
import 'package:rivala/controllers/providers/user/auth_provider.dart';
import 'package:rivala/controllers/repos/auth_repo.dart';
import 'package:rivala/font_customisation/font_customization.dart';
import 'package:rivala/view/screens/master_flow/auth/signIn/signin.dart';
import 'package:rivala/view/screens/persistent_bottom_nav_bar/persistant_bottom_navbar.dart';

import 'controllers/providers/buyer_provider.dart';
import 'controllers/providers/categories_provider.dart';
import 'controllers/providers/collections_provider.dart';
import 'controllers/providers/follow_provider.dart';
import 'controllers/providers/fulfillment.dart';
import 'controllers/providers/hero_section_provider.dart';
import 'controllers/providers/interests_provider.dart';
import 'controllers/providers/media_provider.dart';
import 'controllers/providers/notification_provider.dart';
import 'controllers/providers/pages_provider.dart';
import 'controllers/providers/payment_methods_provider.dart';
import 'controllers/providers/reports_provider.dart';
import 'controllers/providers/squads_provider.dart';
import 'controllers/providers/user/seller_provider.dart';
import 'controllers/repos/media_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final token = await Session().getAuthToken();
  Get.put(ThemeController());
  Get.put(BottomNavBarController());
  Get.put(ImagePickerController());
  Get.put(FontController());
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MediaProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => BrandsProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => FollowProvider()),
        ChangeNotifierProvider(create: (_) => SquadProvider()),
        ChangeNotifierProvider(create: (_) => SellerProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CollectionProvider()),
        ChangeNotifierProvider(create: (_) => LinkProvider()),
        ChangeNotifierProvider(create: (_) => PromoProvider()),
        // New Providers
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => InterestsProvider()),
        ChangeNotifierProvider(create: (_) => BuyerProvider()),
        ChangeNotifierProvider(create: (_) => PaymentMethodsProvider()),
        ChangeNotifierProvider(create: (_) => ReportsProvider()),
        ChangeNotifierProvider(create: (_) => PagesProvider()),
        ChangeNotifierProvider(create: (_) => HeroSectionProvider()),
        ChangeNotifierProvider(create: (_) => fulfillmentPro()),
      ],
      child: MyApp(
        token: token,
      )));
}

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator.registerSingleton<AuthRepo>(AuthRepo(locator<ApiClient>()));
  locator.registerSingleton<MediaRepo>(MediaRepo(locator<ApiClient>()));
  locator.registerLazySingleton(() => MediaProvider());
}

final String dummyImage2 =
    'https://plus.unsplash.com/premium_photo-1661766718556-13c2efac1388?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9jdG9yc3xlbnwwfHwwfHx8MA%3D%3D';

final String dummyImage =
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: token != null
            ? const PersistentBottomNavBar()
            : const MasterSignIn());
  }
}
