import 'package:catbreeds/config/ui/assets.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ImageWithCache extends StatelessWidget {
  const ImageWithCache({
    required this.imageUrl,
    this.needProgressIndicator = false,
    super.key,
  });

  final String imageUrl;
  final bool needProgressIndicator;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: needProgressIndicator
          ? (_, __, ___) => Image.asset(
                AppAssets.loading,
              )
          : null,
      errorWidget: (_, __, ___) => Image.asset(
        AppAssets.notFound,
      ),
    );
  }
}
