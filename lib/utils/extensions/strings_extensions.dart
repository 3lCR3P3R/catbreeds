extension NullableStringsExtension on String? {
  bool get isNotNull {
    if (this == null) {
      return false;
    } else if (this!.isEmpty) {
      return false;
    }

    return true;
  }

  String get getCatImage => 'https://cdn2.thecatapi.com/images/$this.jpg';

  bool get validateUrl => this?.contains('http') ?? false;
}
