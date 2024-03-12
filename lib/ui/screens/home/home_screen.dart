import 'package:catbreeds/config/routes/router_path.dart';
import 'package:catbreeds/ui/widgets/general/input_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:catbreeds/config/texts/strings.dart';
import 'package:catbreeds/config/ui/assets.dart';
import 'package:catbreeds/config/ui/text_styles.dart';
import 'package:catbreeds/enums/loading_states.dart';
import 'package:catbreeds/models/breed/breed.dart';
import 'package:catbreeds/ui/widgets/general/image_cache.dart';
import 'package:catbreeds/utils/extensions/strings_extensions.dart';
import 'package:catbreeds/ui/screens/home/home_provider.dart';

Size? _size;
HomeProvider? _homeProvider;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _size ??= MediaQuery.of(context).size;
    _homeProvider ??= context.read<HomeProvider>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: const Column(
              children: [
                _Tittle(),
                _Search(),
                _LoadingState(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tittle extends StatelessWidget {
  const _Tittle();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: _size!.height * 0.032188841202),
      child: AutoSizeText(
        AppStrings.homeTitle,
        style: AppTextStyles.header,
      ),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InputText(
        controller: _homeProvider!.searchController,
        hintText: 'Search by breed',
        onChange: _homeProvider!.search,
        suffixIconWidget: const Icon(Icons.search),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Selector<HomeProvider, LoadingState>(
        selector: (_, bloc) => bloc.loadingState,
        shouldRebuild: (_, __) => true,
        builder: (_, state, __) {
          if (state == LoadingState.loading) {
            return _image(AppAssets.loading);
          }

          if (state == LoadingState.notFound) {
            return _image(AppAssets.notFound);
          }

          return Selector<HomeProvider, String?>(
            selector: (_, bloc) => bloc.catSearched,
            shouldRebuild: (_, __) => true,
            builder: (_, word, __) => word.isNotNull
                ? const _ListCatCardsFilter()
                : const _ListCatCards(),
          );
        },
      ),
    );
  }

  Widget _image(String asset) => Column(
        children: [
          const Spacer(),
          Image.asset(asset),
          const Spacer(),
        ],
      );
}

class _ListCatCardsFilter extends StatelessWidget {
  const _ListCatCardsFilter();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: _homeProvider!.breedList
          .map((e) => _CatCard(
                breed: e,
              ))
          .toList(),
    );
  }
}

class _ListCatCards extends StatelessWidget {
  const _ListCatCards();

  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, int>(
      selector: (_, bloc) => bloc.currentPage,
      shouldRebuild: (_, __) => true,
      builder: (_, page, __) => ListView.builder(
        controller: _homeProvider!.scrollController,
        itemCount: (page * _homeProvider!.quantity),
        itemBuilder: (context, index) {
          return _CatCard(
            breed: _homeProvider!.originalList[index],
          );
        },
      ),
    );
  }
}

class _CatCard extends StatelessWidget {
  const _CatCard({required this.breed});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.details, arguments: {
        'breed': breed,
      }),
      child: Tooltip(
        message: 'Card of a(an) ${breed.name} cat',
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Tooltip(
                          message: "The cat's breed is ${breed.name}",
                          child: AutoSizeText(
                            breed.name,
                            style: AppTextStyles.subTitle,
                          ),
                        ),
                        const Spacer(),
                        Tooltip(
                          message: AppStrings.tapMoreInfo,
                          child: AutoSizeText(
                            AppStrings.moreInfo,
                            style: AppTextStyles.subTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tooltip(
                    message: 'Image of a(an) ${breed.name} cat',
                    child: ImageWithCache(
                      imageUrl: breed.referenceImageId.getCatImage,
                      needProgressIndicator: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Tooltip(
                          message: "Cat's country is ${breed.origin}",
                          child: AutoSizeText(
                            '${breed.origin}',
                            style: AppTextStyles.subTitle,
                          ),
                        ),
                        const Spacer(),
                        Tooltip(
                          message:
                              "Cat's intelligence is ${breed.intelligence}",
                          child: AutoSizeText(
                            'Intelligence: ${breed.intelligence}',
                            style: AppTextStyles.subTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
