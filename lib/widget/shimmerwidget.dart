import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

// Rectangular
  const ShimmerWidget.rectangular(
      {super.key, this.width = double.infinity, required this.height})
      : shapeBorder = const RoundedRectangleBorder();

// Circle
  const ShimmerWidget.circular(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

// Round corner Container
  const ShimmerWidget.roundcorner(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(15),
      ))});

// for line / text
  const ShimmerWidget.roundrectborder(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(5),
      ))});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: gray.withOpacity(0.40),
        highlightColor: white,
        period: const Duration(seconds: 1),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(5.0),
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
