extension NullableStringsExtension on String? {
  bool get isNotNull {
    if (this == null) {
      return false;
    } else if (this!.isEmpty) {
      return false;
    }

    return true;
  }
}
