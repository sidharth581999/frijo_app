import 'package:flutter/material.dart';
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
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 1200),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
