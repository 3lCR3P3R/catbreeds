import 'package:catbreeds/models/breed/breed.dart';
import 'package:flutter/material.dart';

class DetailsProvider with ChangeNotifier {
  DetailsProvider({required this.breed});

  Breed breed;
}
