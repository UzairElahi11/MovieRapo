import 'package:flutter/material.dart';

class GenericContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadhow;
  final Gradient? gradient;
  final DecorationImage? image;
  final BoxShape? shape;
  final Widget? child;
  final BlendMode? backgroundBlendMode;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxConstraints? constraints;
  final ShapeDecoration? decoration;
  final Clip ? clip;

  const GenericContainer(
      {super.key,
      this.alignment,
      this.height,
      this.width,
      this.color,
      this.borderRadius,
      this.border,
      this.boxShadhow,
      this.gradient,
      this.image,
      this.shape,
      this.child,
      this.backgroundBlendMode,
      this.padding,
      this.margin,
      this.constraints,
      this.decoration,this.clip});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: clip  ?? Clip.none,
      constraints: constraints,
      margin: margin,
      padding: padding,
      alignment: alignment,
      height: height,
      width: width,
      decoration: decoration ??
          BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: border,
            boxShadow: boxShadhow,
            backgroundBlendMode: backgroundBlendMode,
            gradient: gradient,
            image: image,
            shape: shape ?? BoxShape.rectangle,
          ),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
