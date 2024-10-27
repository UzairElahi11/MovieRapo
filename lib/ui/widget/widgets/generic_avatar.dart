import 'package:flutter/material.dart';
import 'package:testmovie/ui/widget/widgets/cache_network_image.dart';

// ignore: must_be_immutable
class GenericAvatar extends StatelessWidget {
  final String image;
  double? radius;
  GenericAvatar({
    super.key,
    required this.image,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.fromSize(
        size: Size.fromRadius(radius ?? 24),
        child: NetworkCacheImage(
          imageUrl: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
