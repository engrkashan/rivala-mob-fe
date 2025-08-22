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
    this.useOutlinedBorder =
        true, // true for outlined border, false for underline
  }) : super(key: key);

  String? label, hint, suffixtext;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  bool? isObSecure,
      haveLabel,
      isFilled,
      isright,
      iscenter,
      useCountryCodePicker,
      showFlag,readOnly,
      useOutlinedBorder,useCustomFont; // Added this flag for choosing border style
  double? marginBottom;
  int? maxLines;
  double? labelSize, radius, hintSize,contentvPad;
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
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
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
                    size:widget.labelSize?? 15,
                    useCustomFont: widget.useCustomFont,
                    paddingBottom: 8,
                    weight: widget.labelWeight ?? FontWeight.w500,
                    color: isFocused
                        ? widget.focusedLabelColor ?? kblack
                        : widget.labelColor ?? kblack,
                  );
                },
              ),
            // if (widget.label != null)
            //   MyText(
            //     text: widget.label ?? '',
            //     size: 14,
            //     paddingBottom: 8,
            //     weight: widget.labelWeight ?? FontWeight.w500,
            //     color: widget.labelColor ?? kGreyColor,
            //   ),
            ValueListenableBuilder(
              valueListenable: _focusNotifier,
              builder: (_, isFocused, child) {
                return TextFormField(
                  onTapOutside: (event) {
                    _focusNode.unfocus();
                  },
                  cursorColor: kblack2,
                  readOnly:widget.readOnly?? false,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines ?? 1,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  onTap: widget.ontapp,
                  textInputAction: TextInputAction.next,
                  obscureText: widget.isObSecure!,
                  obscuringCharacter: '*',
                  style: TextStyle(
                    fontFamily:widget.useCustomFont==true?themeController.selectedFont.value: AppFonts.poppins,
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
                      contentPadding:  EdgeInsets.symmetric(
                          horizontal: 15, vertical:widget.contentvPad??9),
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
                          fontFamily:widget.useCustomFont==true?themeController.selectedFont.value: AppFonts.poppins,
                       
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
                      // Conditional Borders based on user choice
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
                      prefixIconConstraints: BoxConstraints.tightFor(),
                      suffixIconConstraints: BoxConstraints.tightFor()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

///
class MyTextField2 extends StatefulWidget {
  MyTextField2({
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
    this.focusedFilledColor = ktransparent,
    this.fhintColor,
    this.hintColor,
    this.bordercolor,
    this.isright,
    this.radius = 10,
    this.haveLabel = true,
    this.labelSize,
    this.prefixIcon,
    this.suffixtext,
    this.suffixIcon,
    this.suffixTap,
    this.keyboardType,
    this.showFlag,
    this.labelColor,
    this.useCountryCodePicker = false,
    this.isOutline = false,
    this.isEditable = true,
    this.labelWeight,
  }) : super(key: key);

  String? label, hint, suffixtext;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  bool? isObSecure,
      haveLabel,
      isFilled,
      isright,
      useCountryCodePicker,
      showFlag;
  double? marginBottom;
  int? maxLines;
  double? labelSize, radius;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Color? filledColor,
      focusedFilledColor,
      hintColor,
      bordercolor,
      fhintColor,
      labelColor;
  TextInputType? keyboardType;
  VoidCallback? suffixTap;
  FontWeight? labelWeight;
  bool isOutline;
  bool isEditable;

  @override
  _MyTextField2State createState() => _MyTextField2State();
}

class _MyTextField2State extends State<MyTextField2> {
  late FocusNode _focusNode;
  final ValueNotifier<bool> _focusNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _focusNotifier.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    _focusNotifier.value = _focusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [MoveEffect()],
      child: Padding(
        padding: EdgeInsets.only(bottom: widget.marginBottom!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.label != null)
              MyText(
                text: widget.label ?? '',
                size: 16,
                paddingBottom: 8,
                weight: widget.labelWeight ?? FontWeight.bold,
                color: widget.labelColor ?? ksecondary,
              ),
            ValueListenableBuilder(
              valueListenable: _focusNotifier,
              builder: (_, isFocused, child) {
                return TextFormField(
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines ?? 1,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  textInputAction: TextInputAction.next,
                  obscureText: widget.isObSecure!,
                  obscuringCharacter: '*',
                  enabled: widget.isEditable,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 15,
                    color: ksecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  cursorColor: ksecondary,
                  textAlign:
                      widget.isright == true ? TextAlign.right : TextAlign.left,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(
                        backgroundColor: kwhite,
                        color: ksecondary,
                        height: 2.5),
                    prefixIcon: widget.prefixIcon,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    labelText: widget.label ?? widget.hint,
                    labelStyle: TextStyle(
                        fontFamily: AppFonts.poppins,
                        color: widget.hintColor ?? ksecondary,
                        fontSize: 12.5),
                    // Use hint as label to float
                    suffixIcon: widget.suffixIcon != null
                        ? GestureDetector(
                            onTap: widget.suffixTap,
                            child: widget.suffixIcon,
                          )
                        : widget.suffixIcon,
                    suffixStyle: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      color: isFocused ? ksecondary : ksecondary
                    ),
                    suffixText: widget.suffixtext,
                    
                    hintStyle: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 12,
                      color: isFocused
                          ? ksecondary
                          : widget.hintColor ?? ksecondary,
                    ),
                    filled: true,
                    fillColor: isFocused
                        ? widget.focusedFilledColor
                        : widget.filledColor ?? kwhite,
                    enabledBorder: widget.isOutline
                        ? OutlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.bordercolor ??
                                    ktertiary.withOpacity(0.3),
                                width: 1),
                            borderRadius:
                                BorderRadius.circular(widget.radius ?? 15),
                          )
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.bordercolor ??
                                    ktertiary.withOpacity(0.3),
                                width: 1),
                            borderRadius:
                                BorderRadius.circular(widget.radius ?? 15),
                          ),
                    focusedBorder: widget.isOutline
                        ? OutlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.bordercolor ?? ksecondary,
                                width: 1),
                            borderRadius:
                                BorderRadius.circular(widget.radius ?? 15),
                          )
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: widget.bordercolor ?? ksecondary,
                                width: 1.5),
                            borderRadius:
                                BorderRadius.circular(widget.radius ?? 15),
                          ),
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
