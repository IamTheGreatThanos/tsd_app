import 'package:hive/hive.dart';

import '../models/dto_models/response/dto_tokens_reaponse.dart';

class HiveRepository {
  late final Box<String> _stringsBox;

  Future<void> init() async {
    registerAdapters();
    _stringsBox = await Hive.openBox<String>(BoxNames.stringBox);

  }

  void registerAdapters() {

  }


  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _stringsBox.put(BoxKeys.access_token_key, accessToken);
    await _stringsBox.put(BoxKeys.refresh_token_key, refreshToken);
  }

  DTOTokensResponse getTokens() {
    final accessToken =
        _stringsBox.get(BoxKeys.access_token_key, defaultValue: '')!;
    final refreshToken =
        _stringsBox.get(BoxKeys.refresh_token_key, defaultValue: '')!;
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
  static const String block_time_key = 'block_time_key';
  static const String attempt_key = 'attempt_key';
  static const String access_token_key = 'access_token_key';
  static const String refresh_token_key = 'refresh_token_key';
  static const String confirmation_code_key = 'confirmation_code_key';
  static const String attach_code_key = 'attach_code_key';
  static const String settings_key = 'settings_key';
  static const String user_avatar_key = 'user_avatar_key';
}

class HiveTypeIds {
  static const int attemptModel = 0;
  static const int settingsModel = 1;
  static const int userAvatarModel = 2;
}
