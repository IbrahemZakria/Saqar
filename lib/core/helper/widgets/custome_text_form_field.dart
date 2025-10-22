import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/helper/thems/app_text_syles.dart';

// ignore: must_be_immutable
class CustomeTextFormField extends StatelessWidget {
  CustomeTextFormField({
    super.key,
    this.textFormFieldKey,
    this.obscureText = false,
    this.hintText,
    this.onchanged,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.textColor = Colors.black,
    this.controller,
    this.borderRadius,
    this.maxLines,
    this.bordercolor = Colors.white,
    this.textType = TextInputType.emailAddress,
  });
  double? borderRadius;
  String? hintText;
  String? Function(String?)? validator;
  Function(String)? onchanged;
  void Function(String?)? onSaved;
  bool obscureText;
  Widget? prefixIcon;
  GlobalKey<FormFieldState<dynamic>>? textFormFieldKey;
  Widget? suffixIcon;
  Color bordercolor;
  Color? textColor;
  TextEditingController? controller;
  int? maxLines;
  TextInputType? textType;
  OutlineInputBorder buildborder({
    Color bordercolor = AppColors.kprimarycolor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      borderSide: BorderSide(color: bordercolor, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textFormFieldKey,
      onSaved: onSaved,
      enableSuggestions: true,
      controller: controller,
      validator: (value) {
        return validator != null ? validator!(value) : null;
      },
      onChanged: onchanged,
      maxLines: maxLines ?? 1,
      style: TextStyle(color: textColor),
      obscureText: obscureText,
      keyboardType: textType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.kopacityBlackColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText ?? '',
        hintStyle: AppTextSyles.textStyle16se(
          context,
        ).copyWith(color: Colors.white.withAlpha(120)),
        enabledBorder: buildborder(),

        errorBorder: buildborder(),
        focusedBorder: buildborder(),
        focusedErrorBorder: buildborder(),
      ),
    );
  }
}
