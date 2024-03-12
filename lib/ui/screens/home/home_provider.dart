import 'dart:async';
import 'package:flutter/material.dart';

import 'package:catbreeds/enums/loading_states.dart';
import 'package:catbreeds/utils/extensions/strings_extensions.dart';

import 'package:catbreeds/repositories/cat_api_repository.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    getBreads();
    scrollController.addListener(scrollListener);
  }

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  LoadingState loadingState = LoadingState.loading;

  List originalList = [];
  List breedList = [];

  final int quantity = 5;
  int currentPage = 0;

  String? catSearched;
  Timer? searchOnStoppedTyping;

  String? search(String? value) {
    catSearched = value;

    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel();
    }

    if (!value.isNotNull) {
      breedList = [];
      notifyListeners();
      return value;
    }

    searchOnStoppedTyping = Timer(
      const Duration(milliseconds: 250),
      () {
        breedList = originalList
            .where((breed) =>
                breed.name.toLowerCase().contains(value!.toLowerCase()))
            .toList();

        notifyListeners();
      },
    );

    return value;
  }

  Future<void> getBreads() async {
    originalList = await catRepository.getBreeds();

    if (originalList.isEmpty) {
      loadingState = LoadingState.notFound;
      return notifyListeners();
    }

    loadingState = LoadingState.found;
    currentPage = 1;

    notifyListeners();
  }

  void scrollListener() {
    if (originalList.isEmpty) return;

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    currentPage += 1;

    if ((currentPage * quantity) > originalList.length) {
      currentPage -= 1;
    }

    notifyListeners();

    Future.delayed(
      const Duration(milliseconds: 800),
      () => scrollController.animateTo(
        scrollController.position.pixels + 100,
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
