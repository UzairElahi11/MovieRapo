import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testmovie/ui/widget/widgets/app_colors.dart';
import 'package:testmovie/ui/widget/widgets/app_images.dart';
import 'package:testmovie/ui/widget/widgets/svg_loader.dart';


class NetworkCacheImage extends StatelessWidget {
  final String imageUrl;
  final Map<String, String>? header;
  final Alignment? alignment;
  final String? cacheKey;
  final Color? color;
  final BlendMode? blendMode;
  final BoxFit? fit;

  final String? errorImage;
  final double? height;
  final double? width;

  const NetworkCacheImage({
    super.key,
    required this.imageUrl,
    this.header,
    this.alignment,
    this.cacheKey,
    this.color,
    this.blendMode,
    this.fit,
    this.height,
    this.width,
    this.errorImage,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return CircleAvatar(
        radius: 40,
        backgroundColor: Colors.transparent,
        child: SvgLoader(
          svgPath: errorImage ?? "",
        ),
      );
    }

    return CachedNetworkImage(
      height: height,
      width: width,
      colorBlendMode: blendMode,
      fit: fit,
      placeholder: (context, _) => Center(
        child: SvgLoader(
          fit: BoxFit.contain,
          height: 24,
          width: 24,
          svgPath: AppImages.icUsers,
        ),
      ),
      color: color,
      alignment: alignment ?? Alignment.center,
      cacheKey: cacheKey,
      httpHeaders: header,
      imageUrl: imageUrl,
      errorWidget: (context, error, stackTrace) => CircleAvatar(
        radius: 40,
        backgroundColor: AppColors.instance.colorF3F3F3,
        child: SvgLoader(
          svgPath: AppImages.icUsers,
        ),
      ),
    );
  }
}
