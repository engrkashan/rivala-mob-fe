import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/link_provider.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/link_model.dart';
import 'package:rivala/view/screens/master_flow/auth/signUp/create_linkss/manuall_links/create_new_link.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';

class ImportLinktree extends StatefulWidget {
  final List<LinkModel> importedLinks;
  const ImportLinktree({super.key, this.importedLinks = const []});

  @override
  State<ImportLinktree> createState() => _IndiviualLinkState();
}

class _IndiviualLinkState extends State<ImportLinktree> {
  // Track selected indices
  Set<int> selectedIndices = {};

  @override
  void initState() {
    super.initState();
    // Select all by default
    selectedIndices =
        List.generate(widget.importedLinks.length, (index) => index).toSet();
  }

  void _submitLinks() async {
    final linkProvider = Provider.of<LinkProvider>(context, listen: false);
    final brandsProvider = Provider.of<BrandsProvider>(context, listen: false);

    // Ensure we have current store loaded
    if (brandsProvider.currentStore == null) {
      await brandsProvider.loadCurrentStore();
    }
    final storeId = brandsProvider.currentStore?.id;

    if (storeId == null) {
      AlertInfo.show(
          context: context, text: 'Could not identify current store.');
      return;
    }

    if (selectedIndices.isEmpty) {
      AlertInfo.show(
          context: context, text: 'Please select at least one link.');
      return;
    }

    // Filter to only selected links
    List<LinkModel> linksToUpload = [];
    for (var index in selectedIndices) {
      final link = widget.importedLinks[index];
      linksToUpload.add(link.copyWith(storeId: storeId, thumbnailUrl: ''));
    }

    try {
      await linkProvider.setLinks(linksToUpload);
      AlertInfo.show(context: context, text: 'Links imported successfully');

      // Refresh links in the provider so the previous screen shows them
      await linkProvider.loadLinks(context);

      // Go back to CreateNewLink (which is 2 steps back: ImportLinktree -> ImportLinktreeEmail -> CreateNewLink)
      // Or just go back to the screen that can handle it.
      // Since we want to go back to CreateNewLink:
      Get.until(
          (route) => Get.currentRoute == '/CreateNewLink' || route.isFirst);

      // If the above doesn't work well with GetX named routes, we can just use:
      // Navigator.of(context).popUntil((route) => route.settings.name == 'CreateNewLink');

      // But let's try a simpler approach if we don't know the exact route name for sure:
      // Get.back(); // to Email screen
      // Get.back(); // to CreateNewLink

      // Actually, many developers prefer to just go back to the links list.
      Get.offAll(() => CreateNewLink(hasAddOpt: true));
    } catch (e) {
      AlertInfo.show(context: context, text: 'Failed to save links: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: simpleAppBar(
            context: context,
            title: 'Import from LinkTree',
            centerTitle: true,
            actions: [
              Bounce_widget(
                  widget: Image.asset(
                Assets.imagesClose,
                width: 18,
                height: 18,
              )),
              SizedBox(
                width: 12,
              )
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
                physics: const BouncingScrollPhysics(),
                children: [
                  Image.asset(
                    Assets.imagesLinktree,
                    width: 95,
                    height: 95,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.importedLinks.length,
                    itemBuilder: (context, index) {
                      final link = widget.importedLinks[index];
                      final isSelected = selectedIndices.contains(index);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedIndices.remove(index);
                              } else {
                                selectedIndices.add(index);
                                print(selectedIndices);
                              }
                            });
                          },
                          child: add_link_container(
                            title: link.name,
                            link: link.url,
                            delay: (index + 1) * 200,
                            isRadio: true, // Reusing isRadio to show checkbox
                            isSelected: isSelected, // Pass selection state
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Consumer<LinkProvider>(builder: (context, provider, _) {
              return MyButton(
                buttonText:
                    provider.isLoading ? 'Adding...' : 'Add selected links',
                mBottom: 50,
                mhoriz: 35,
                onTap: provider.isLoading
                    ? null
                    : () {
                        _submitLinks();
                      },
              );
            }),
          ],
        ));
  }
}
