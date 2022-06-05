import 'package:hive/hive.dart';

import 'package:pharmacy_arrival/app/network/models/dto_models/response/dto_tokens_reaponse.dart';

class HiveRepository {
  late final Box<String> _stringsBox;

  Future<void> init() async {
    registerAdapters();
    _stringsBox = await Hive.openBox<String>(BoxNames.stringBox);

  }

  void registerAdapters() {

  }


  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _stringsBox.put(BoxKeys.accessTokenKey, accessToken);
    await _stringsBox.put(BoxKeys.refreshTokenKey, refreshToken);
  }

  DTOTokensResponse getTokens() {
    final accessToken =
        _stringsBox.get(BoxKeys.accessTokenKey, defaultValue: '')!;
    final refreshToken =
        _stringsBox.get(BoxKeys.refreshTokenKey, defaultValue: '')!;
    return DTOTokensResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

class BoxNames {
  static const String blockTimeBox = 'block_time_box';
  static const String attemptBox = 'attempt_box';
  static const String stringBox = 'string_box';
  static const String confirmationCodeBox = 'confirmation_code_box';
  static const String attachCodeBox = 'attach_code_box';
  static const String settingsBox = 'settings_box';
  static const String userAvatarBox = 'user_avatar_box';
}

class BoxKeys {
  static const String blockTimeKey = 'block_time_key';
  static const String attemptKey = 'attempt_key';
  static const String accessTokenKey = 'access_token_key';
  static const String refreshTokenKey = 'refresh_token_key';
  static const String confirmationCodeKey = 'confirmation_code_key';
  static const String attachCodeKey = 'attach_code_key';
  static const String settingsKey = 'settings_key';
  static const String userAvatarKey = 'user_avatar_key';
}

class HiveTypeIds {
  static const int attemptModel = 0;
  static const int settingsModel = 1;
  static const int userAvatarModel = 2;
}
