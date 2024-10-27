import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testmovie/ui/widget/widgets/app_colors.dart';
import 'package:testmovie/ui/widget/widgets/extensions/padding_extension.dart';
import 'package:testmovie/ui/widget/widgets/generic_space.dart';
import 'package:testmovie/ui/widget/widgets/generic_text.dart';
import 'package:testmovie/ui/widget/widgets/styles.dart';


class GenericTextField extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final bool isSecure;
  final bool readOnly;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final Color? focusBorderSideColor;
  final Color? unFocusBorderSideColor;
  final Color? hintColor;
  final void Function(String)? onFieldSubmitted;
  final TextStyle? style;
  final Color? filledColor;
  final bool? filled;
  final TextStyle? hintStyle;

  const GenericTextField(
      {required this.title,
      this.titleStyle,
      this.onFieldSubmitted,
      super.key,
      required this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.hintText,
      this.isSecure = false,
      this.textInputType,
      this.inputFormatters,
      this.validator,
      this.onChanged,
      this.readOnly = false,
      this.onTap,
      this.focusBorderSideColor,
      this.unFocusBorderSideColor,
      this.hintColor,
      this.style,
      this.filledColor,
      this.filled,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GenericText(
            title,
            style: titleStyle ??
                AppTextStyles.font14_800(
                  AppColors.instance.colorFFFFFF,
                ),
          ),
          const Gap(spacing: 10),
          TextFormField(
            onFieldSubmitted: onFieldSubmitted,
            onTap: onTap,
            readOnly: readOnly,
            inputFormatters: inputFormatters,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: isSecure,
            controller: controller,
            style: style ?? AppTextStyles.font14_500(AppColors.instance.colorFFFFFF),
            decoration: InputDecoration(
              fillColor: filledColor,
              filled: filled ?? false,
              contentPadding: (0, 20).symmetricPadding,
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: hintStyle ?? AppTextStyles.font14_400(hintColor ?? AppColors.instance.colorB9B9B9),
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                  color: unFocusBorderSideColor ?? AppColors.instance.colorFFFFFF,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                  color: focusBorderSideColor ?? AppColors.instance.colorFFFFFF,
                ),
              ),
            ),
            validator: validator,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
