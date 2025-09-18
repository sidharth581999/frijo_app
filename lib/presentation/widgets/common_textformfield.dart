
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/extentions.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obsecureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final InputBorder? border;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefix;
  final Widget? suffix;
  final InputBorder? errorBorder; 
  final InputBorder? focusBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusErrorBorder;
  final bool? filled;
  final int? maxLines;
  final Color? fillColor;
  final double? height;
  final bool? isReadonly ;
  final VoidCallback? onTap;
  final TextInputType? keybordType;

  const CommonTextFormField({
    super.key, required this.controller, this.obsecureText, this.isReadonly, this.validator, this.border, required this.hintText, this.hintStyle, this.contentPadding, this.prefix, this.errorBorder, this.focusBorder, this.enabledBorder, this.focusErrorBorder, this.onChanged, this.errorStyle, this.textStyle, this.filled, this.maxLines, this.fillColor, this.height, this.suffix, this.onTap, this.keybordType
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUnfocus,
        keyboardType: keybordType ?? TextInputType.text,
        onTap: onTap,
        readOnly: isReadonly?? false,
                  controller: controller,
                  obscureText: obsecureText?? false,
                  validator: validator,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    
                    filled: filled?? true,
                    fillColor: fillColor ?? ColorResources.blackBG,
                    
                    border: border?? OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5.sdp),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: hintText,
                    contentPadding: height != null
        ? EdgeInsets.symmetric(vertical: (height! - 24) / 2, horizontal: 12) 
        : EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    prefixIcon: prefix,
                    hintStyle: hintStyle?? TextStyle(
                      fontSize: 14.sdp,
                      fontWeight: FontWeight.w300,
                      color: ColorResources.greyHint
                    ),
                    focusedBorder: focusBorder?? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.white,
                        width:  0.5.sdp,
                      ),
                    ),
                    enabledBorder: enabledBorder?? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.white,
                        width:  0.5.sdp,
                      ),
                    ),
                    errorBorder: errorBorder?? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.red,
                        width:  1.sdp,
                      ),
                    ),
                    focusedErrorBorder: focusErrorBorder?? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.red,
                        width:  1.sdp,
                      ),
                    ),
                    errorStyle: errorStyle?? TextStyle(color: ColorResources.red,fontSize: 12.sdp),
                    suffixIcon: suffix
                  ),
                  onChanged: onChanged,
                  style: textStyle?? TextStyle(
                    fontSize: 14.sdp,
                    fontWeight: FontWeight.w300,
                      color: ColorResources.white
                  ),
                ),
    );
  }
}