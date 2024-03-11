import 'package:catbreeds/config/ui/assets.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ImageWithCache extends StatelessWidget {
  const ImageWithCache({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      errorWidget: (_, __, ___) => Image.asset(
        AppAssets.notFound,
      ),
    );
  }
}
