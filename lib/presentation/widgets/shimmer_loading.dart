import 'package:flutter/material.dart';
import 'package:frijo/application/core/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const ShimmerLoader.rectangular({
    super.key,
    this.height = 16,
    this.width = double.infinity,
    this.borderRadius = 8,
  });

  const ShimmerLoader.circular({
    super.key,
    required double size,
  })  : height = size,
        width = size,
        borderRadius = size / 2;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorResources.darkGrey,
      highlightColor: ColorResources.greyHint,
      period: const Duration(milliseconds: 1200),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: ColorResources.darkGrey,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
