

import 'package:pharmacy_arrival/app/network/repository/hive_repository.dart';

class TokensRepository {
  late final HiveRepository _hiveRepository;

  String _accessToken = '';
  String _refreshToken = '';

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  ///auth limp
  // String get accessToken => 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1ha3NpbGlxQGdtYWlsLmNvbSIsInN1YiI6OSwicGFyZW50cyI6W10sInJvbGVzIjpbMSwxOF0sImlhdCI6MTYzNzczOTU1MiwiZXhwIjoxNjY5Mjc1NTUyfQ.wzkUDarICokZSHeesHAI3q91aJSZl00lMeF4uv-pgk8';
  // String get refreshToken => '_refreshToken';

  Future<void> init(HiveRepository hiveRepository) async {
    _hiveRepository = hiveRepository;
    final tokens = _hiveRepository.getTokens();
    _accessToken = tokens.accessToken;
    _refreshToken = tokens.refreshToken;
  }

  bool hasToken() => accessToken.isNotEmpty;

  Future<void> save(String accessToken) async {
    _accessToken = accessToken;
    await _hiveRepository.saveTokens(accessToken, refreshToken);
    _accessToken = accessToken;
  }

  Future<bool> delete() async {
    try {
      await _hiveRepository.saveTokens('', '');
      _accessToken = '';
      return true;
    } catch (e) {
      return false;
    }
  }
}
