import 'package:flutter/material.dart';
import 'package:testmovie/ui/widget/widgets/generic_container.dart';

class GenericButton extends StatelessWidget {
  final double? width, height, radius, textSize;
  final Color? color, textColor;
  final EdgeInsets? margin, padding;
  final VoidCallback? onPressed;
  final Widget? child;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Widget? leading;

  const GenericButton({
    Key? key,
    this.onPressed,
    this.height,
    this.width,
    this.textSize,
    this.color,
    this.textColor,
    this.radius,
    this.margin,
    this.padding,
    this.borderColor,
    this.textStyle,
    this.borderRadius,
    this.leading,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        type: MaterialType.transparency,
        child: GenericContainer(
          alignment: Alignment.center,
          margin: margin ?? EdgeInsets.zero,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
          padding: padding,
          width: width ?? double.infinity,
          height: height,
          borderRadius: BorderRadius.circular(
            radius ?? 50,
          ),
          color: color,
          child: child,
        ),
      ),
    );
  }
}
