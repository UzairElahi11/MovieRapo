import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgLoader extends StatelessWidget {
  final String svgPath;
  final double? height;
  final double? width;
  final ColorFilter? color;
  final BoxFit? fit;

  const SvgLoader({
    Key? key,
    required this.svgPath,
    this.height,
    this.width,
    this.color,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      width: width,
      fit: fit ?? BoxFit.cover,
      colorFilter: color,
    );
  }
}
