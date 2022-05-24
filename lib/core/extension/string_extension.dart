extension StringCasingExtension on String {
  // String capitalize() {
  //     return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  //   }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
