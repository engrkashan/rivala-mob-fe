import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/main.dart';
import 'package:rivala/controllers/providers/collections_provider.dart';
import 'package:rivala/controllers/providers/user/auth_provider.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/view/screens/master_flow/new_post/post_display.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/add_product/new_collection.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/add_product/view_added_product.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/bounce_widget.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/custome_comtainer.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';
import 'package:rivala/view/widgets/post_detail_widget.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';

class AddProductInstore extends StatefulWidget {
  final ProductModel? product;
  const AddProductInstore({super.key, this.product});

  @override
  State<AddProductInstore> createState() => _AddProductInstoreState();
}

class _AddProductInstoreState extends State<AddProductInstore> {
  String? selectedCollectionId;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CollectionProvider>().loadAllCollections();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      dummyimgeStack(),
        Scaffold(
          backgroundColor: ktransparent,
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: image_appbar(),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomeContainer(
                  height: 530,
                  color: kwhite,
                  hpad: 0,
                  vpad: 0,
                  widget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: ContainerAppbar(
                          title: 'Add product to my storefront',
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          color: kgrey2,
                        ),
                      ),
                      MyText(
                        text: 'Account',
                        size: 14,
                        color: kheader, //kter
                        weight: FontWeight.w400,
                        paddingLeft: 18,
                        paddingBottom: 10,
                         useCustomFont: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Consumer<AuthProvider>(
                          builder: (context, auth, _) {
                            return Row(
                              children: [
                                CommonImageView(
                                  url: auth.user?.avatarUrl ?? dummyImage2,
                                  width: 36,
                                  height: 36,
                                  radius: 100,
                                ),
                                Expanded(
                                  child: MyText(
                                    text: auth.user?.name ?? auth.user?.username ?? 'Store Owner',
                                    size: 16,
                                    color: kheader, //kter
                                    weight: FontWeight.w600,
                                    paddingLeft: 8,
                                    useCustomFont: true,
                                  ),
                                ),
                                MyText(
                                  text: 'Change',
                                  size: 14,
                                  color: kheader, //kter
                                  weight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  useCustomFont: true,
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 18),
                        child: Divider(
                          color: kgrey2,
                        ),
                      ),
                      MyText(
                        text: 'Collection',
                        size: 14,
                        color: kheader, //kter
                        weight: FontWeight.w400,
                        paddingLeft: 18,
                        paddingBottom: 10,
                         useCustomFont: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Consumer<CollectionProvider>(
                                builder: (context, ref, _) {
                                  if (ref.isLoading && ref.allCollections.isEmpty) {
                                    return const SizedBox(
                                      height: 30,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: CircularProgressIndicator()
                                      ),
                                    );
                                  }
                                  if (ref.allCollections.isEmpty) {
                                    return const Text("No collections yet.");
                                  }
                                  
                                  // Auto-select first collection if none selected
                                  if (selectedCollectionId == null && ref.allCollections.isNotEmpty) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      if (mounted) {
                                        setState(() {
                                          selectedCollectionId = ref.allCollections.first.id;
                                        });
                                      }
                                    });
                                  }

                                  return Wrap(
                                    spacing: 5,
                                    children: ref.allCollections.map((col) {
                                      bool isSelected = selectedCollectionId == col.id;
                                      return Bounce_widget(
                                        ontap: () {
                                          setState(() {
                                            selectedCollectionId = col.id;
                                          });
                                        },
                                        widget: TagsWidget(
                                          tag: col.name ?? 'Collection',
                                          bgColor: isSelected ? kblack : ktransparent,
                                          fontColor: isSelected ? kwhite : kbody,
                                          tagIcon: Assets.imagesCollection2,
                                          useCustomFont: true,
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                            MyText(
                              text: '+ New',
                              size: 14,
                              color: kheader, //kter
                              weight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                               useCustomFont: true,
                              onTap: () {
                                Get.to(() => AddProductNewCollection());
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 18),
                        child: Divider(
                          color: kgrey2,
                        ),
                      ),
                      MyText(
                        text: 'Product',
                        size: 14,
                        color: kheader,
                        weight: FontWeight.w400,
                        paddingLeft: 18,
                        paddingBottom: 10,
                         useCustomFont: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: widget.product != null 
                            ? store_product_row(product: widget.product!)
                            : const SizedBox(height: 120, child: Center(child: Text("No product provided"))),
                      ),
                      Spacer(),
                      CustomeContainer(
                        hasShadow: true,
                        color: kwhite,
                        radius: 50,
                        widget: Consumer<CollectionProvider>(
                          builder: (context, ref, _) {
                            return MyButton(
                              icon: Icons.add,
                              imgColor: kwhite,
                              fontColor: kwhite,
                              buttonText: ref.isLoading ? 'Adding...' : 'Add to store',
                              useCustomFont: true,
                              onTap: () async {
                                if (ref.isLoading) return;
                                
                                if (selectedCollectionId == null) {
                                  AlertInfo.show(context: Get.context!, text: "Please select a collection first.");
                                  return;
                                }
                                if (widget.product?.id == null) {
                                  AlertInfo.show(context: Get.context!, text: "Invalid product.");
                                  return;
                                }

                                await ref.addProductToCollection(selectedCollectionId!, widget.product!.id!);
                                
                                if (ref.error.isNotEmpty) {
                                  AlertInfo.show(context: Get.context!, text: ref.error);
                                } else {
                                  AlertInfo.show(context: Get.context!, text: "Product added to collection successfully!");
                                  Get.back();
                                }
                              },
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}

class store_product_row extends StatelessWidget {
  final ProductModel product;
  const store_product_row({
    super.key,
    required this.product
  });

  @override
  Widget build(BuildContext context) {
    String image = Assets.imagesDummyimage2;
    bool isNetworkImg = false;
    if (product.image != null && product.image!.isNotEmpty) {
      image = product.image!.first;
      isNetworkImg = true;
    }

    return Bounce_widget(
      ontap: () {
        // Preview product if needed
      },
      widget: Row(
        children: [
          Stack(
            children: [
              CommonImageView(
                imagePath: isNetworkImg ? null : image,
                url: isNetworkImg ? image : null,
                width: 110,
                height: 120, // Image height
                radius: 15,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Bounce_widget(
                  widget: CommonImageView(
                    imagePath: product.store?.logoUrl == null ? Assets.imagesApolo2 : null,
                    url: product.store?.logoUrl,
                    width: 25,
                    height: 25,
                    radius: 100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: product.title ?? 'Product Name',
                    size: 16,
                    color: kheader,
                    weight: FontWeight.w600,
                    maxLines: 2,
                    textOverflow: TextOverflow.visible,
                     useCustomFont: true,
                  ),
                  MyText(
                    text: '\$${product.price?.toStringAsFixed(2) ?? "0.00"}',
                    size: 14,
                    color: kbody,
                    weight: FontWeight.w400,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                     useCustomFont: true,
                  ),
                  MyText(
                    text: '@${product.store?.name ?? "store"}',
                    size: 14,
                    color: kbody,
                    weight: FontWeight.w400,
                    maxLines: 2,
                    textOverflow: TextOverflow.visible,
                     useCustomFont: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
