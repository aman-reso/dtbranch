import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String? imagePath;
  final Color? color;
  final dynamic fit;
  final bool circular;

  const MyImage({
    Key? key,
    this.width,
    this.height,
    required this.imagePath,
    this.color,
    this.fit,
    this.circular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: circular ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Image.asset(
        "assets/images/$imagePath",
        width: width,
        height: height,
        color: color,
        fit: fit,
        errorBuilder: (context, url, error) {
          return Image.asset(
            "assets/images/no_image_port.png",
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
