import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';

import 'my_text_widget.dart';

class ImagePickerBottomSheet2 extends StatelessWidget {
  const ImagePickerBottomSheet2({
    Key? key,
    required this.onCameraPick,
    required this.onGalleryPick,
  }) : super(key: key);

  final VoidCallback onCameraPick;
  final VoidCallback onGalleryPick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                // Center(
                //   child: Image.asset(
                //     Assets.imagesBottomSheetHandle,
                //     height: 5,
                //   ),
                // ),
                MyText(
                  paddingLeft: 15,
                  paddingTop: 20,
                  paddingBottom: 10,
                  text: 'Upload from',
                  size: 16,
                  color: Colors.black,
                  weight: FontWeight.w600,
                ),
              ],
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: onCameraPick,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        MyText(
                          paddingTop: 10,
                          text: 'Camera',
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: ktertiary,
                    width: 1.0,
                  ),
                  GestureDetector(
                    onTap: onGalleryPick,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.black,
                          size: 40,
                        ),
                        MyText(
                          paddingTop: 10,
                          text: 'Gallery',
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
