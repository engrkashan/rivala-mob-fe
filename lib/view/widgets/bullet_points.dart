
import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';







// ignore: must_be_immutable
class MyBullet extends StatelessWidget {

  MyBullet({super.key, required this.point,this.color,this.weight,this.size});
  String point;
  Color? color;
  FontWeight? weight;
  double? size;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: '•',
          // paddingLeft: 5,
          paddingBottom: 6,
           paddingRight: 10,
          color: color??kgrey2,
        ),
        Expanded(
          child: MyText(
            text: point,
            size:size?? 12,
            color:color??kgrey2,
            textOverflow: TextOverflow.ellipsis,
            maxLines: 4,
            weight:weight?? FontWeight.w500,
            paddingRight: 10,
          ),
        ),
      ],
    );
  }
}