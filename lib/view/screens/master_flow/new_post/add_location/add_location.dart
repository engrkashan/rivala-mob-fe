import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../controllers/providers/post_provider.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  bool isLoading = true;
  bool isSearching = false;
  String? userLocation;
  String? selectedLocation;
  final TextEditingController _searchController = TextEditingController();
  final List<String> searchResults = [];
  Timer? _searchDebounce;
  int _searchToken = 0;

  @override
  void initState() {
    super.initState();
    selectedLocation = context.read<PostProvider>().selectedLocation;
    _fetchUserLocation();
  }

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
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final location =
          placemarks.isNotEmpty ? _formatPlacemark(placemarks.first) : null;

      setState(() {
        userLocation = location ?? 'Failed to fetch location';
        selectedLocation ??= location;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Location error: $e");
      userLocation = 'Failed to fetch location';
      setState(() => isLoading = false);
    }
  }

  void _onSearchChanged(String query) {
    _searchDebounce?.cancel();
    final trimmedQuery = query.trim();

    if (trimmedQuery.length < 3) {
      setState(() {
        isSearching = false;
        searchResults.clear();
      });
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _searchLocations(trimmedQuery);
    });
  }

  Future<void> _searchLocations(String query) async {
    final token = ++_searchToken;
    setState(() {
      isSearching = true;
      searchResults.clear();
    });

    try {
      final locations = await locationFromAddress(query);
      final results = <String>[];

      for (final location in locations.take(5)) {
        final placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        if (placemarks.isEmpty) continue;

        final formatted = _formatPlacemark(placemarks.first);
        if (formatted.isNotEmpty && !results.contains(formatted)) {
          results.add(formatted);
        }
      }

      if (!mounted || token != _searchToken) return;

      setState(() {
        searchResults
          ..clear()
          ..addAll(results);
        isSearching = false;
      });
    } catch (e) {
      if (!mounted || token != _searchToken) return;

      setState(() {
        isSearching = false;
        searchResults.clear();
      });
    }
  }

  String _formatPlacemark(Placemark place) {
    return [
      place.name,
      place.locality,
      place.administrativeArea,
      place.country,
    ].where((part) => part != null && part.trim().isNotEmpty).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final hasSearchQuery = _searchController.text.trim().length >= 3;

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
                    controller: _searchController,
                    radius: 50,
                    filledColor: kgrey4,
                    hint: 'Search locations . . .',
                    bordercolor: ktransparent,
                    onChanged: _onSearchChanged,
                    suffixIcon: Image.asset(
                      Assets.imagesSearch,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (isSearching)
                  const Center(
                    child: CircularProgressIndicator(color: kblack),
                  )
                else if (hasSearchQuery)
                  _LocationResults(
                    locations: searchResults,
                    selectedLocation: selectedLocation,
                    onSelect: (location) {
                      setState(() {
                        selectedLocation = location;
                      });
                    },
                  )
                else if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: kblack),
                  )
                else if (userLocation != null)
                  _LocationRow(
                    title: userLocation!,
                    isSelected: selectedLocation == userLocation,
                    onTap: () {
                      setState(() {
                        selectedLocation = userLocation;
                      });
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
            ontap: () {
              final location = selectedLocation ?? userLocation;
              if (location != null) {
                context.read<PostProvider>().setLocation(location);
              }
              Get.back();
            },
            ontap2: () => Get.back(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}

class _LocationResults extends StatelessWidget {
  final List<String> locations;
  final String? selectedLocation;
  final ValueChanged<String> onSelect;

  const _LocationResults({
    required this.locations,
    required this.selectedLocation,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return Center(child: MyText(text: 'No locations found'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: _LocationRow(
            title: location,
            isSelected: selectedLocation == location,
            onTap: () => onSelect(location),
          ),
        );
      },
    );
  }
}

class _LocationRow extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LocationRow({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce_widget(
      ontap: onTap,
      widget: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? kbackground : ktransparent,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 22,
          vertical: isSelected ? 8 : 0,
        ),
        child: Row(
          children: [
            Image.asset(
              Assets.imagesLocation,
              width: 21,
              height: 21,
            ),
            Expanded(
              child: MyText(
                text: title,
                size: 14,
                color: kblack,
                paddingLeft: 18,
              ),
            ),
            CustomCheckBox(
              isActive: isSelected,
              onTap: onTap,
              borderColor: kblack,
              iscircle: true,
              circleIcon: Icons.check,
            )
          ],
        ),
      ),
    );
  }
}
