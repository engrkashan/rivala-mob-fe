import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/providers/media_provider.dart';
import 'package:rivala/controllers/providers/tax_document_provider.dart';
import 'package:rivala/models/tax_document.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/custom_check_box.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_field.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';

import '../../../../../../generated/assets.dart';
import '../../../../../widgets/bounce_widget.dart';
import '../../../../../widgets/common_image_view_widget.dart';
import '../../../../../widgets/custom_dropdown.dart';
import '../../../../../widgets/custome_comtainer.dart';

class TaxDocumentation extends StatefulWidget {
  final TaxDocumentModel? model;
  const TaxDocumentation({super.key, this.model});

  @override
  State<TaxDocumentation> createState() => _TaxDocumentationState();
}

class _TaxDocumentationState extends State<TaxDocumentation> {
  bool isBusiness = true;
  late String type;

  final numController = TextEditingController();
  final nameCon = TextEditingController();
  final addressCon = TextEditingController();

  @override
  void initState() {
    super.initState();

    type = widget.model?.type ?? 'GST';

    if (widget.model != null) {
      numController.text = widget.model!.number ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaProvider = Provider.of<MediaProvider>(context);
    return Scaffold(
      backgroundColor: kwhite,
      appBar: simpleAppBar(
          context: context, title: 'Tax Documents', centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
              physics: const BouncingScrollPhysics(),
              children: [
                // Toggle Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CustomCheckBox(
                          isActive: isBusiness,
                          onTap: () {
                            setState(() {
                              isBusiness = true;
                            });
                          },
                          iscircle: true,
                          borderColor: kblack,
                          selectedColor: kwhite,
                          iconColor: kblack,
                          unSelectedColor: kwhite,
                        ),
                        MyText(
                          text: 'Business',
                          size: 15,
                          weight: FontWeight.w500,
                          color: kblack,
                          paddingLeft: 5,
                        )
                      ],
                    ),
                    const SizedBox(width: 25),
                    Row(
                      children: [
                        CustomCheckBox(
                          isActive: !isBusiness,
                          onTap: () {
                            setState(() {
                              isBusiness = false;
                            });
                          },
                          iscircle: true,
                          borderColor: kblack,
                          selectedColor: kwhite,
                          iconColor: kblack,
                          unSelectedColor: kwhite,
                        ),
                        MyText(
                          text: 'Personal',
                          size: 15,
                          weight: FontWeight.w500,
                          color: kblack,
                          paddingLeft: 5,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Conditional Fields
                if (isBusiness) ...[
                  MyText(
                    text: 'Upload your tax document',
                    size: 15,
                    color: kblack,
                    weight: FontWeight.w500,
                    paddingTop: 30,
                    paddingBottom: 15,
                  ),
                  Bounce_widget(
                    ontap: () {
                      mediaProvider.pickImage();
                    },
                    widget: CustomeContainer(
                      radius: 15,
                      color: kgrey4,
                      vpad: 25,
                      widget: Center(
                        child: CommonImageView(
                          imagePath: Assets.imagesUpload,
                          url: widget.model?.documentUrl,
                          file: mediaProvider.selectedImage,
                          width: 70,
                          height: 70,
                        ),

                        //     child: Image.asset(
                        //   Assets.imagesUpload,
                        //   width: 70,
                        //   height: 70,
                        // )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: numController,
                    hint: widget.model?.number ?? '1234567890',
                    label: 'EIN',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                  ),
                  // MyText(
                  //   text: 'Business Name',
                  //   size: 15,
                  //   weight: FontWeight.w500,
                  //   color: kblack,
                  // ),
                  // MyText(
                  //   text: '*if different than name',
                  //   fontStyle: FontStyle.italic,
                  //   color: kblack,
                  //   size: 9,
                  //   paddingBottom: 8,
                  // ),
                  // MyTextField(
                  //   controller: nameCon,
                  //   hint: 'Nutrition Rescue',
                  //   bordercolor: ktransparent,
                  //   filledColor: kgrey2,
                  // ),
                  CustomDropDown(
                      delay: 500,
                      label: 'Type',
                      hint: 'GST',
                      items: ['GST', 'VAT', 'EIN', "OTHER"],
                      selectedValue: type,
                      bordercolor: ktransparent,
                      bgColor: kgrey2,
                      onChanged: (e) {
                        type = e;
                        setState(() {});
                      }),
                  // MyTextField(
                  //   controller: addressCon,
                  //   hint: '123 N 456 S, Bountiful Utah, 84108',
                  //   label: 'Business Address',
                  //   bordercolor: ktransparent,
                  //   filledColor: kgrey2,
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  // row_widget(
                  //   icon: Assets.imagesExport2,
                  //   iconSize: 18,
                  //   title: 'Export 1099',
                  //   textColor: kblue,
                  // ),
                  SizedBox(
                    height: 10,
                  )
                ] else ...[
                  MyText(
                    text: 'Upload your tax document',
                    size: 15,
                    color: kblack,
                    weight: FontWeight.w500,
                    paddingTop: 30,
                    paddingBottom: 15,
                  ),
                  Bounce_widget(
                    ontap: () {
                      mediaProvider.pickImage();
                    },
                    widget: CustomeContainer(
                      radius: 15,
                      color: kgrey4,
                      vpad: 25,
                      widget: Center(
                        child: CommonImageView(
                          imagePath: Assets.imagesUpload,
                          url: widget.model?.documentUrl,
                          file: mediaProvider.selectedImage,
                          width: 70,
                          height: 70,
                        ),

                        //     child: Image.asset(
                        //   Assets.imagesUpload,
                        //   width: 70,
                        //   height: 70,
                        // )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: numController,
                    hint: widget.model?.number ?? '123-45-6789',
                    label: 'Social Security',
                    bordercolor: ktransparent,
                    filledColor: kgrey2,
                  ),

                  // MyText(
                  //   text: 'Name',
                  //   size: 15,
                  //   weight: FontWeight.w500,
                  //   color: kblack,
                  // ),
                  // MyText(
                  //   text: '*if different than name',
                  //   fontStyle: FontStyle.italic,
                  //   color: kblack,
                  //   size: 9,
                  //   paddingBottom: 8,
                  // ),
                  // MyTextField(
                  //   controller: nameCon,
                  //   hint: 'Nutrition Rescue',
                  //   bordercolor: ktransparent,
                  //   filledColor: kgrey2,
                  // ),
                  CustomDropDown(
                      delay: 800,
                      label: 'Type',
                      hint: 'GST',
                      items: ['GST', 'VAT', 'EIN', "OTHER"],
                      selectedValue: type,
                      bordercolor: ktransparent,
                      bgColor: kgrey2,
                      onChanged: (e) {
                        type = e;
                        setState(() {});
                      }),
                  // MyTextField(
                  //   hint: '123 Elm Street, Apt 4B, New York, NY, 10001',
                  //   label: 'Address',
                  //   bordercolor: ktransparent,
                  //   filledColor: kgrey2,
                  //   controller: addressCon,
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  // row_widget(
                  //   icon: Assets.imagesExport2,
                  //   iconSize: 18,
                  //   title: 'Export 1099',
                  //   textColor: kblue,
                  // ),
                  SizedBox(
                    height: 10,
                  )
                ],
                context.watch<TaxDocumentProvider>().isLoading ||
                        mediaProvider.isLoading
                    ? SizedBox(
                        width: 20,
                        child: Center(child: CircularProgressIndicator()))
                    : MyButton(
                        buttonText: widget.model != null
                            ? "update Document"
                            : "Add Document",
                        onTap: () async {
                          final taxProvider =
                              context.read<TaxDocumentProvider>();
                          final media = context.read<MediaProvider>();

                          // Prevent double submission
                          if (taxProvider.isLoading) return;

                          try {
                            // 1. Upload first (only if image selected)
                            if (media.selectedImage != null) {
                              await media.upload();

                              if (media.uploadedUrl == null ||
                                  media.uploadedUrl!.isEmpty) {
                                AlertInfo.show(
                                  context: context,
                                  text:
                                      "Document upload failed. Please try again.",
                                );
                                return;
                              }
                            }

                            // 2. Build model AFTER successful upload
                            final model = TaxDocumentModel(
                              number: numController.text.trim(),
                              type: type,
                              documentUrl: media.uploadedUrl,
                            );

                            // 3. Create vs Update (single responsibility)
                            if (widget.model != null) {
                              await taxProvider.updateDocument(
                                  widget.model!.id!, model);
                            } else {
                              await taxProvider.createDocument(model);
                            }

                            // 4. Centralized error handling
                            if (taxProvider.error != null &&
                                taxProvider.error!.isNotEmpty) {
                              AlertInfo.show(
                                context: context,
                                text: taxProvider.error!,
                              );
                              return;
                            }

                            // 5. Success exit
                            Navigator.pop(context);
                          } catch (e) {
                            AlertInfo.show(
                              context: context,
                              text: "Something went wrong. Please try again.",
                            );
                          }
                        },
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
