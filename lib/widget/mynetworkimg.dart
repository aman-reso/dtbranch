import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? imgHeight;
  final double? imgWidth;
  final dynamic fit;
  final bool circular; // New parameter for circular image

  const MyNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.fit,
    this.imgHeight,
    this.imgWidth,
    this.circular = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imgHeight,
      width: imgWidth,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: circular ? BoxShape.circle : BoxShape.rectangle, // Apply circular shape if circular is true
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) {
          return MyImage(
            width: imgWidth,
            height: imgHeight,
            imagePath: imageUrl.contains('land_')
                ? "no_image_land.png"
                : "no_image_port.png",
            fit: BoxFit.cover,
            circular: circular, // Pass circular parameter to MyImage widget
          );
        },
        errorWidget: (context, url, error) {
          return MyImage(
            width: imgWidth,
            height: imgHeight,
            imagePath: imageUrl.contains('land_')
                ? "no_image_land.png"
                : "no_image_port.png",
            fit: BoxFit.cover,
            circular: circular, // Pass circular parameter to MyImage widget
          );
        },
      ),
    );
  }
}

