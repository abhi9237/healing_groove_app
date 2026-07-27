extension StringHelper on String? {
  /// Returns an empty string if null.
  String get orEmpty => this ?? '';

  /// Capitalizes only the first letter.
  String get capitalizeFirst {
    if (this == null || this!.trim().isEmpty) return '';

    final text = this!.trim();
    return text[0].toUpperCase() + text.substring(1);
  }

}