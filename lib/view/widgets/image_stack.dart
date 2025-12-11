import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/common_image_view_widget.dart';

// ignore: must_be_immutable

List<String> images = [
  'https://images.unsplash.com/photo-1520600661691-801f48869ee4?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fHw%3D',
  'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
  'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
];

class StackedImagesWidget extends StatelessWidget {
  final TextDirection direction;
  List<String> urlImages;
  final double size;
  final double xShift;
  final Color? extracolor, outlineExtra, textcolor;
  StackedImagesWidget(
      {Key? key,
      this.direction = TextDirection.ltr,
      this.urlImages = const [],
      this.size = 30,
      this.xShift = 20,
      this.outlineExtra,
      this.extracolor,
      this.textcolor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();
    return SizedBox(
      width: Get.width,
      height: 35,
      child: Stack(
        children: List.generate(items.length, (index) {
          final shift = index * xShift;
          return Positioned(
            left: direction == TextDirection.ltr ? shift : -shift,
            child:
                //  index == 3
                //     ? Container(
                //         height: size,
                //         width: size,
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //             color: extracolor??kwhite,
                //             border: Border.all(color: outlineExtra??kwhite)

                //            ),
                //         child: Center(
                //           child: MyText(
                //            /// paddingLeft: 8,
                //           text:   '+${items.length - 4}', // Show the remaining number of images

                //               color: textcolor ?? Colors.black,

                //               size: 12,

                //           ),
                //         ),
                //       )
                //     :
                items[index],
          );
        }),
      ),
    );
  }

  Widget buildImage(String urlImage) {
    final double borderSize = 0;
    return Container(
      padding: EdgeInsets.all(borderSize),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kwhite, width: 1.4)),
      child: CommonImageView(
        url: urlImage,
        fit: BoxFit.cover,
        height: size,
        width: size,
        radius: 100,
      ),
    );
  }
}
