import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_display.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/add_product/add_product_instore.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';

class AddProductNewCollection extends StatefulWidget {
  const AddProductNewCollection({super.key});

  @override
  State<AddProductNewCollection> createState() =>
      _AddProductNewCollectionState();
}

class _AddProductNewCollectionState extends State<AddProductNewCollection> {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: image_appbar(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: CustomeContainer(
                    color: kwhite,
                    hpad: 0,
                    vpad: 0,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: ContainerAppbar(
                            title: 'New Collection',
                            isCenter: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Divider(color: kgrey2),
                        ),
                        MyText(
                          text: 'Collection name',
                          size: 14,
                          color: kheader,
                          weight: FontWeight.w400,
                          paddingLeft: 18,
                          paddingBottom: 10,
                          useCustomFont: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: MyTextField(
                            controller: nameController,
                            radius: 50,
                            hint: 'Digital Products',
                            useCustomFont: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: MyTextField(
                            controller: descController,
                            radius: 15,
                            hint: '280 character limit. . .',
                            label: 'Collection description',
                            useCustomFont: true,
                            maxLines: 7,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomeContainer(
                          hasShadow: true,
                          color: kwhite,
                          radius: 50,
                          widget: Consumer<CollectionProvider>(
                            builder: (context, ref, _) {
                              return MyButton(
                                fontColor: kwhite,
                                onTap: () async {
                                  if (nameController.text.trim().isEmpty) {
                                    AlertInfo.show(context: context, text: "Name cannot be empty");
                                    return;
                                  }
                                  if (ref.isLoading) return;

                                  await ref.setCollection(nameController.text.trim(), descController.text.trim(), context, productIds: []);
                                  
                                  if (ref.error.isNotEmpty) {
                                    AlertInfo.show(context: context, text: ref.error);
                                  } else {
                                    Get.back();
                                  }
                                },
                                buttonText: ref.isLoading ? 'Saving...' : 'Save Collection',
                                useCustomFont: true,
                              );
                            }
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
