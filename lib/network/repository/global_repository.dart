import '../services/network_service.dart';
import 'hive_repository.dart';

class GlobalRepository {
  late final NetworkService _networkService;

  void init(NetworkService networkService, HiveRepository hiveRepository) {
    _networkService = networkService;
  }

}
