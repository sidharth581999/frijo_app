import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final double width;
  final double height;
  final Color? bgColor;
  final Color? textColor;
  final IconData? icon;

  const ErrorMessage({
    Key? key,
    required this.message,
    this.width = double.infinity,
    this.height = 60,
    this.bgColor = ColorResources.blackBG,
    this.textColor = ColorResources.greyTextloginScreen,
    this.icon = Icons.error_outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
