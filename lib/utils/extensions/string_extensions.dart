extension StringUtils on String {
  String get extractDigits {
    if (isEmpty) return '';

    var output = '';
    for (var i = 0; i < length; i++) {
      if (int.tryParse(this[i]) != null) output += this[i];
    }
    return output;
  }

  String get formatAsPhone {
    final _digits = extractDigits;
    if (_digits.isEmpty) return '';
    final output = <String>[];
    output.add('+${_digits.substring(0, 1)}');
    output.add(' (${_digits.substring(1, 4)})');
    output.add(' ${_digits.substring(4, 7)}-');
    output.add('${_digits.substring(7, 9)}-');
    output.add(_digits.substring(9, _digits.length));
    return output.join();
  }

  ///get string with [qty] of non-breakable spaces
  String nbsp(int qty) => String.fromCharCodes(List.filled(qty, 0x00A0));

  String padRightNbsp(int minWidth) {
    final qtyToAdd = minWidth - length;
    return qtyToAdd > 0 ? this + nbsp(qtyToAdd) : this;
  }

  String padRightNbspX2(int minWidth) {
    final qtyToAdd = minWidth - length;
    return qtyToAdd > 0 ? this + nbsp(qtyToAdd * 2) : this;
  }

  String get separateByThousands {
    var text = extractDigits;
    var length = text.length;
    var subChunks = <String>[];
    var subChunk = '';
    for (var i = length - 1; i >= 0; i--) {
      subChunk = text[i] + subChunk;
      if (subChunk.length % 3 == 0 || i == 0) {
        subChunks.insert(0, subChunk);
        subChunk = '';
      }
    }
    return subChunks.join(String.fromCharCode(0x00A0));
  }

  String get fileExt {
    var output = '';
    final chunks = split('.');
    if (chunks.length > 1) {
      output = chunks.last;
    }
    return output;
  }

  String get fileName {
    final chunks = split('/');
    return chunks.isNotEmpty ? chunks.last : '';
  }

  bool get containsLetters {
    return contains(RegExp(r'[a-zA-Z]'));
  }

  String get toCapitalized {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }

  String get removeSpaces => replaceAll(' ', '').replaceAll(
    String.fromCharCode(0x00A0),
    '',
  );
  String get removeTrailingDots {
    return removeSpaces
        .replaceFirst(
      '.',
      '#',
    )
        .split('.')
        .join('')
        .replaceFirst(
      '#',
      '.',
    );
  }

  String get separateThousands {
    var text = replaceAll(' ', '');
    var length = text.length;
    var subChunks = <String>[];
    String subChunk = '';
    for (int i = length - 1; i >= 0; i--) {
      subChunk = text[i] + subChunk;
      if (subChunk.length % 3 == 0 || i == 0) {
        subChunks.insert(0, subChunk);
        subChunk = '';
      }
    }
    return subChunks.join(String.fromCharCode(0x00A0));
  }

  String limitSymbols(int symbols) {
    return substring(0, length >= symbols ? symbols : length);
  }
}

extension StringNullUtils on String? {
  String formatAsCurrency({int decimals = 0}) {
    String output;
    if (this == null) return '';
    if (this!.isEmpty) return '';
    output = this!.removeTrailingDots;
    if (output[0] == '.') output = '0' + output;
    var chunks = output.split('.');
    chunks.first = chunks.first.separateThousands;
    if (decimals == 0 || chunks.length == 1) return chunks.first;
    chunks[1] = chunks[1].limitSymbols(decimals);
    if (chunks[1].endsWith('0')) chunks[1] = chunks[1][0];
    return chunks.join('.');
  }

  String? get withCurrencySign {
    if (this == null) return null;
    return '$this ₸';
  }
}
