import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/models/post_model.dart';
import 'package:rivala/models/product_model.dart';
import 'package:rivala/view/screens/master_store_flow/store_home/product_detailed_description.dart';
import 'package:rivala/view/widgets/appbar.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';
import 'package:rivala/view/widgets/my_button.dart';
import 'package:rivala/view/widgets/store_widgets/dummyimage.dart';
import 'package:rivala/view/widgets/store_widgets/image_layout_widget.dart';
import 'package:rivala/view/widgets/store_widgets/store_image_stack.dart';

class MultipleProductPostVeiw extends StatefulWidget {
  final PostModel? post;
  const MultipleProductPostVeiw({super.key, this.post});

  @override
  State<MultipleProductPostVeiw> createState() =>
      _MultipleProductPostVeiwState();
}

class _MultipleProductPostVeiwState extends State<MultipleProductPostVeiw> {
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      if (widget.post!.taggedProducts != null && widget.post!.taggedProducts!.isNotEmpty) {
        products = widget.post!.taggedProducts!;
      } else if (widget.post!.product != null) {
        products = [widget.post!.product!];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      dummyimgeStack(),
      Scaffold(
          backgroundColor: ktransparent,
          body: ImageLayoutWidget(
              bodyWidget: Column(children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ContainerAppbar(
                title: widget.post?.title ?? 'Linked Products',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: kgrey2,
              ),
            ),
            
            if (products.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageView(
                        imagePath: Assets.imagesBag,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(height: 20),
                      Text("Oops! No products linked.", 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: kblack),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text("This post doesn't have any attached products.", 
                        style: TextStyle(color: kdargrey, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ]
                  ),
                ),
              )
            else
              GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 260),
                itemBuilder: (context, index) {
                  final prod = products[index];
                  String? img;
                  if (prod.image != null && prod.image!.isNotEmpty) {
                    img = prod.image!.first;
                  }
                  
                  return store_image_stack(
                    height: 200,
                    singlePrice: true,
                    title: prod.title,
                    price: "\$${prod.price?.toStringAsFixed(2) ?? '0.00'}",
                    url: img,
                    onTap: () {
                      Get.to(() => ProductDetailedDescription(product: prod));
                    }
                  );
                },
              ),
            SizedBox(
              height: 10,
            ),
            Mybutton2(
              buttonText: 'Back',
              ontap: () {
                    Get.back();
              },
              useCustomFont: true,
              bgColor: kwhite,
              borderColor: kbutton,
              fontColor: kbutton,
            )
          ])))
    ]);
  }
}
