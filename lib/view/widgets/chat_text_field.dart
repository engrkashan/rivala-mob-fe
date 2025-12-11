import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/generated/assets.dart';
import 'package:rivala/view/widgets/my_text_field.dart';

class ChatsTextField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSend;

  const ChatsTextField({
    super.key,
    this.controller,
    this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: kgrey4,
          blurRadius: 2,
          spreadRadius: 2,
          offset: Offset(0, 2),
        ),
      ], borderRadius: BorderRadius.circular(18)),
      child: MyTextField(
        controller: controller,
        hint: 'Message',
        filledColor: kwhite,
        bordercolor: ktransparent,
        marginBottom: 0,
        suffixIcon: SizedBox(
          // height: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onSend != null)
                    IconButton(
                        onPressed: onSend,
                        icon: Icon(Icons.send, color: Colors.black)),
                  if (onSend == null) ...[
                    Image.asset(
                      Assets.imagesMic,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      Assets.imagesGallery,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      Assets.imagesCamera,
                      width: 20,
                      height: 20,
                    )
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
