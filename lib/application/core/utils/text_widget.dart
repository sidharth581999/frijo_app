
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:frijo/application/core/utils/device_size.dart';
import 'package:frijo/application/core/utils/extentions.dart';


class TextWidget extends StatelessWidget {
  const TextWidget({super.key,this.text,this.style,this.textAlign,this.maxLines,this.overflow,this.textColor});

  final String? text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(text ?? '',textAlign: textAlign, style: style?.copyWith(fontFamily: 'Poppins',color: textColor ?? style?.color ?? (context.dynamicColor(light: ColorResources.white, dark: ColorResources.white,)), fontSize: DeviceSize.scale(style?.fontSize ?? 12)),maxLines: maxLines,overflow: overflow,);
  }
}
