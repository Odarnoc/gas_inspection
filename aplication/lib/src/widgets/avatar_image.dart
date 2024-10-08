import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String image;
  final double? width;
  final BorderRadius? borderRadius;
  final Widget? child;

  const AvatarImage(
      {super.key,
      required this.image,
      this.borderRadius,
      this.width,
      this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(10)),
              child: image.isEmpty || image.length <= 10
                  ? Image.asset('assets/no-image.png')
                  : CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) =>
                          Image.asset('assets/no-image.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/no-image.png'),
                    ),
            ),
          ),
          child ?? Container()
        ],
      ),
    );
  }
}
