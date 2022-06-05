class SmallUtils {
  static String splitSym = ',';

  static String beautifyName(String name) {
    String _formatCase(String str) {
      if (str.length <= 1) return str;
      return str[0].toUpperCase() + str.substring(1).toLowerCase();
    }

    const symbols = r'/\([^()]*\)/g';
    const symbols2 = '/;/g';
    name = name.replaceAllMapped(symbols, (match) => '');
    name = name.replaceAllMapped(symbols2, (match) => ',');

    name = name.split(' ').map((e) => _formatCase(e)).join(' ');
    return name.split(', ').reversed.join(', ').toLowerCase();
  }
}
