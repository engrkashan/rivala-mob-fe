
import 'package:flutter/material.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/view/widgets/my_text_widget.dart';


class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({
    required this.text,
  });

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: widget.text,
          color:ktertiary,
          weight: FontWeight.w400,
          size: 14,
          // paddingBottom: 25,

        
          maxLines: !_isExpanded ? 3 : 25,
          textOverflow: TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: MyText(
            text: !_isExpanded ? "See more" : "See less",
            size: 13,
            color:ksecondary,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}