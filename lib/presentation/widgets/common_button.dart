
import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';

class CommonButton extends StatelessWidget {
  final Color buttoncolor;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadious;
  final bool? isBoarder; 
  final Color? boarderColor;
  const CommonButton({
    super.key, required this.buttoncolor, required this.onTap, required this.height, required this.width, required this.child, this.padding, this.borderRadious, this.isBoarder, this.boarderColor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttoncolor,
          border: Border.all(
            color: boarderColor?? ColorResources.white,
            style: isBoarder== true? BorderStyle.solid :BorderStyle.none),
          borderRadius: BorderRadius.circular(borderRadious??15),
        ),
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: padding??const EdgeInsets.all(0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
            ],
          ),
        ),
      ),
    );
  }
}
