import 'package:catbreeds/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:catbreeds/config/ui/text_styles.dart';
import 'package:catbreeds/ui/screens/details/details_provider.dart';
import 'package:catbreeds/ui/widgets/general/image_cache.dart';
import 'package:catbreeds/utils/extensions/strings_extensions.dart';

Size? _size;
DetailsProvider? _detailsProvider;

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _size ??= MediaQuery.of(context).size;
    _detailsProvider = context.read<DetailsProvider>();

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: const Column(
          children: [_Header(), _StaticImage(), _BreedInformation()],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      margin: EdgeInsets.only(top: _size!.height * 0.032188841202),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          AutoSizeText(
            _detailsProvider!.breed.name,
            style: AppTextStyles.header,
            // style: ,
          ),
        ],
      ),
    );
  }
}

class _StaticImage extends StatelessWidget {
  const _StaticImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ImageWithCache(
        imageUrl: _detailsProvider!.breed.referenceImageId.getCatImage,
        needProgressIndicator: true,
      ),
    );
  }
}

class _BreedInformation extends StatelessWidget {
  const _BreedInformation();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          children: _detailsProvider!.breed
              .toMap()
              .entries
              .map((e) => _BreedInformationItem(
                    title: e.key,
                    value: e.value,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _BreedInformationItem extends StatelessWidget {
  const _BreedInformationItem({
    required this.title,
    this.value,
  });

  final String title;
  final dynamic value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: '$value'.validateUrl ? () => openLink(value) : null,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: AutoSizeText.rich(
          TextSpan(
            children: [
              TextSpan(text: '$title: ', style: AppTextStyles.subTitle),
              TextSpan(text: '$value', style: AppTextStyles.normalText),
            ],
          ),
        ),
      ),
    );
  }
}
