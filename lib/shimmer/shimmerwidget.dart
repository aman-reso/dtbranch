import 'package:dtlive/utils/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final Color shimmerColor;

// Rectangular
  const ShimmerWidget.rectangular(
      {super.key,
      this.width = double.infinity,
      this.shimmerColor = lightBlack,
      required this.height})
      : shapeBorder = const RoundedRectangleBorder();

// Circle
  const ShimmerWidget.circular({
    super.key,
    this.width = double.infinity,
    this.shimmerColor = lightBlack,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

// Round corner Container
  const ShimmerWidget.roundcorner({
    super.key,
    this.width = double.infinity,
    this.shimmerColor = lightBlack,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))),
  });

// for line / text
  const ShimmerWidget.roundrectborder({
    super.key,
    this.width = double.infinity,
    this.shimmerColor = lightBlack,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4))),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: shimmerColor,
        highlightColor: lightGray.withOpacity(0.001),
        enabled: true,
        period: kIsWeb ? Duration.zero : const Duration(milliseconds: 800),
        loop: 0,
        direction: ShimmerDirection.ltr,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: shimmerColor,
            shape: shapeBorder,
          ),
        ),
      );
}
