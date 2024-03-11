import 'package:catbreeds/config/ui/text_styles.dart';
import 'package:catbreeds/ui/widgets/general/image_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:catbreeds/config/texts/strings.dart';
import 'package:catbreeds/ui/screens/splash/splash_provider.dart';

Size? _size;
SplashProvider? _splashProvider;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _splashProvider ??= context.read<SplashProvider>();
    _size ??= MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              child: AutoSizeText(
                AppStrings.splashTitle,
                style: AppTextStyles.header,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 35),
              width: _size!.width * 0.80,
              height: _size!.height * 0.45,
              child: ImageWithCache(
                imageUrl: _splashProvider!.getImageByRandomId(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
