import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rivala/consts/app_colors.dart';
import 'package:rivala/controllers/font_controller.dart';

import '../../consts/app_fonts.dart';
import 'my_text_widget.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  MyTextField({
    Key? key,
    this.controller,
    this.hint,
    this.label,
    this.onChanged,
    this.isObSecure = false,
    this.marginBottom = 15.0,
    this.maxLines,
    this.isFilled = true,
    this.filledColor,
    this.focusedFilledColor,
    this.fhintColor,
    this.hintColor,
    this.bordercolor,
    this.isright,
    this.radius = 15,
    this.haveLabel = true,
    this.labelSize,
    this.prefixIcon,
    this.suffixtext,
    this.suffixIcon,
    this.suffixTap,
    this.keyboardType,
    this.showFlag,
    this.labelColor,
    this.labelWeight,
    this.validator,
    this.textColor,
    this.fbordercolor,
    this.focusedLabelColor,
    this.focusNode,
    this.hintSize,
    this.ontapp,
    this.iscenter,
    this.delay,
    this.readOnly,
    this.contentvPad,
    this.useCustomFont,
    this.useCountryCodePicker = false,
    this.errorText,                    // ✅ Added
    this.useOutlinedBorder = true,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onEditingComplete,
  }) : super(key: key);
  TextInputAction? textInputAction;
  ValueChanged<String>? onFieldSubmitted;
  VoidCallback? onEditingComplete;
  String? errorText;
  String? label, hint, suffixtext;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  bool? isObSecure,
      haveLabel,
      isFilled,
      isright,
      iscenter,
      useCountryCodePicker,
      showFlag,
      readOnly,
      useOutlinedBorder,
      useCustomFont;
  double? marginBottom;
  int? maxLines;
  double? labelSize, radius, hintSize, contentvPad;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Color? filledColor,
      focusedFilledColor,
      focusedLabelColor,
      hintColor,
      bordercolor,
      fbordercolor,
      fhintColor,
      textColor,
      labelColor;
  FontWeight? labelWeight;
  TextInputType? keyboardType;
  VoidCallback? suffixTap, ontapp;
  FocusNode? focusNode;
  int? delay;
  String? Function(String?)? validator;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late FocusNode _focusNode;
  final ValueNotifier<bool> _focusNotifier = ValueNotifier<bool>(false);
  final ThemeController themeController = Get.find();

  bool _isLocalFocusNode = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _isLocalFocusNode = true;
    }
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_isLocalFocusNode) {
      _focusNode.dispose();
    }
    _focusNotifier.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    _focusNotifier.value = _focusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        MoveEffect(delay: Duration(milliseconds: widget.delay ?? 100)),
        FadeEffect(duration: Duration(milliseconds: 300)),
        SlideEffect(delay: Duration(milliseconds: 200))
      ],
      child: Padding(
        padding: EdgeInsets.only(bottom: widget.marginBottom!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.label != null)
              ValueListenableBuilder(
                valueListenable: _focusNotifier,
                builder: (_, isFocused, child) {
                  return MyText(
                    text: widget.label ?? '',
                    size: widget.labelSize ?? 15,
                    useCustomFont: widget.useCustomFont,
                    paddingBottom: 8,
                    weight: widget.labelWeight ?? FontWeight.w500,
                    color: isFocused
                        ? widget.focusedLabelColor ?? kblack
                        : widget.labelColor ?? kblack,
                  );
                },
              ),
            ValueListenableBuilder(
              valueListenable: _focusNotifier,
              builder: (_, isFocused, child) {
                return TextFormField(
                  onTapOutside: (event) {
                    _focusNode.unfocus();
                  },
                  cursorColor: kblack2,
                  readOnly: widget.readOnly ?? false,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines ?? 1,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  onTap: widget.ontapp,
                 // textInputAction: widget.textInputAction,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  onEditingComplete: widget.onEditingComplete,
                  textInputAction: TextInputAction.next,
                  obscureText: widget.isObSecure!,
                  obscuringCharacter: '*',
                  style: TextStyle(
                    fontFamily: widget.useCustomFont == true
                        ? themeController.selectedFont.value
                        : AppFonts.poppins,
                    fontSize: 15,
                    color: widget.textColor ?? kblack,
                    fontWeight: FontWeight.w400,
                  ),
                  validator: widget.validator,
                  textAlign: widget.isright == true
                      ? TextAlign.right
                      : widget.iscenter == true
                      ? TextAlign.center
                      : TextAlign.left,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: widget.prefixIcon != null
                          ? widget.prefixIcon
                          : null,
                    ),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 15, vertical: widget.contentvPad ?? 9),
                    hintText: widget.hint,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: widget.suffixIcon != null
                          ? GestureDetector(
                        onTap: widget.suffixTap,
                        child: widget.suffixIcon,
                      )
                          : widget.suffixIcon,
                    ),
                    suffixStyle: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 12,
                      color: isFocused
                          ? widget.fhintColor ?? ktertiary
                          : widget.hintColor ?? ktertiary,
                    ),
                    suffixText: widget.suffixtext,
                    hintStyle: TextStyle(
                      fontFamily: widget.useCustomFont == true
                          ? themeController.selectedFont.value
                          : AppFonts.poppins,
                      fontSize: widget.hintSize ?? 12,
                      fontWeight: FontWeight.normal,
                      color: isFocused
                          ? widget.fhintColor ?? ktertiary
                          : widget.hintColor ?? ktertiary,
                    ),
                    filled: true,
                    fillColor: isFocused
                        ? widget.focusedFilledColor ?? kwhite
                        : widget.filledColor ?? kwhite,

                    // Conditional Borders
                    enabledBorder: widget.useOutlinedBorder == true
                        ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.bordercolor ?? ktertiary,
                          width: 1),
                      borderRadius:
                      BorderRadius.circular(widget.radius ?? 8),
                    )
                        : UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.bordercolor ?? ktertiary,
                          width: 1),
                    ),

                    focusedBorder: widget.useOutlinedBorder == true
                        ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.fbordercolor ?? ktertiary,
                          width: 1),
                      borderRadius:
                      BorderRadius.circular(widget.radius ?? 8),
                    )
                        : UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.bordercolor ?? ktertiary,
                          width: 1.5),
                    ),

                    // ✅ Fixed: Only one set of error borders (Red)
                    errorBorder: widget.useOutlinedBorder == true
                        ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5),
                      borderRadius:
                      BorderRadius.circular(widget.radius ?? 8),
                    )
                        : UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5),
                    ),

                    focusedErrorBorder: widget.useOutlinedBorder == true
                        ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.5),
                      borderRadius:
                      BorderRadius.circular(widget.radius ?? 8),
                    )
                        : UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 2),
                    ),

                    errorText: widget.errorText,
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    errorMaxLines: 2,

                    prefixIconConstraints: BoxConstraints.tightFor(),
                    suffixIconConstraints: BoxConstraints.tightFor(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}