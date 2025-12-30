import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/screens/master_flow/new_post/tag_collection/tag_collection.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  bool isLoading = true;
  String? userLocation;

  @override
  void initState() {
    super.initState();
    _fetchUserLocation();
  }

  /// 📍 Fetch location + convert to address
  Future<void> _fetchUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        userLocation = 'Location services disabled';
        setState(() => isLoading = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        userLocation = 'Location permission denied';
        setState(() => isLoading = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      final place = placemarks.first;

      setState(() {
        userLocation =
            '${place.name}, ${place.locality}, ${place.administrativeArea}';
        isLoading = false;
      });
    } catch (e) {
      print("Location error: ${e}");
      userLocation = 'Failed to fetch location';
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
        context: context,
        title: 'Add location',
        centerTitle: true,
        actions: [
          Bounce_widget(
            ontap: () => Get.back(),
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
          const Divider(color: kgrey2),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15),
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: MyTextField(
                    radius: 50,
                    filledColor: kgrey4,
                    hint: 'Search locations . . .',
                    bordercolor: ktransparent,
                    suffixIcon: Image.asset(
                      Assets.imagesSearch,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// 📍 User Location
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: kblack),
                  )
                else if (userLocation != null)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: icon_text_row(
                          hasIcon: false,
                          title: userLocation!,
                          textSize: 14,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          Mybutton2(
            buttonText2: 'Cancel',
            buttonText: 'Done',
            mbot: 30,
            hpad: 22,
            ontap: () => Get.back(),
            ontap2: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
