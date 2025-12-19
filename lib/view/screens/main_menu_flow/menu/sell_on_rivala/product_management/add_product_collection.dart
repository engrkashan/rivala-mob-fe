import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';

class AddProductCollection extends StatefulWidget {
  const AddProductCollection({super.key});

  @override
  State<AddProductCollection> createState() => _AddProductCollectionState();
}

class _AddProductCollectionState extends State<AddProductCollection> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();

  Future<void> _handleSave() async {
    final name = nameCtrl.text.trim();
    final desc = descCtrl.text.trim();

    if (name.isEmpty) {
      Get.snackbar("Error", "Name is required");
      return;
    }

    final provider = context.read<CollectionProvider>();
    await provider.setCollection(name, desc, context);

    if (provider.error.isEmpty) {
      Get.back();
      Get.snackbar("Success", "Collection created");
    } else {
      Get.snackbar("Error", provider.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: kwhite),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ContainerAppbar(
                  title: 'New Collection',
                  textColor: kblack,
                  icon: Assets.imagesClose2,
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: nameCtrl,
                  hint: 'Size',
                  label: 'Collection Name',
                ),
                MyTextField(
                  controller: descCtrl,
                  hint:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore. Lorem ipsum dolor sit amet.',
                  label: 'Collection Description',
                  maxLines: 4,
                ),
                MyText(
                  text: '+ Add Product to Collection',
                  color: kblue,
                  weight: FontWeight.w500,
                  size: 12,
                  paddingBottom: 30,
                  paddingTop: 20,
                ),
                Consumer<CollectionProvider>(builder: (context, provider, _) {
                  return provider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MyButton(
                          buttonText: 'Save collection',
                          mBottom: 30,
                          onTap: _handleSave,
                        );
                })
              ],
            ))));
  }
}
