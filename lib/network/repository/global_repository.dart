import 'package:pharmacy_arrival/screens/auth/ui/_vmodel.dart';

import '../services/network_service.dart';
import 'hive_repository.dart';

class GlobalRepository {
  late final NetworkService _networkService;

  void init(NetworkService networkService, HiveRepository hiveRepository) {
    _networkService = networkService;
  }

  Future<void> register(SignInVModel vModel) async =>
      _networkService.register(vModel);

  Future<void> login(SignInVModel vModel) async =>
      _networkService.login(vModel);

  Future<void> loginQr(String qrToken) async =>
      _networkService.loginQr(qrToken);
}
