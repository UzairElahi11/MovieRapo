import 'package:flutter/material.dart';
import 'package:testmovie/ui/widget/widgets/app_colors.dart';
import 'package:testmovie/ui/widget/widgets/extensions/padding_extension.dart';
import 'package:testmovie/ui/widget/widgets/generic_container.dart';

class BackIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color ?  arrowColor;
  final Color ?  internalColor;
  final Color ?  containerBorderColor;
  const BackIcon({super.key, this.onTap, this.containerBorderColor, this.arrowColor, this.internalColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: GenericContainer(
        padding: (5, 5).symmetricPadding,
        shape: BoxShape.circle,
        color: internalColor,
        border: Border.all(
          color:containerBorderColor ??  AppColors.instance.colorFFFFFF,
        ),
        child: Icon(
          Icons.arrow_back,
          color: arrowColor ??  AppColors.instance.colorFFFFFF,
        ),
      ),
    );
  }
}
