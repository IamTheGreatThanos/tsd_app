import 'package:flutter/cupertino.dart';

import '../network/repository/hive_repository.dart';

class UserStore extends ChangeNotifier {
  late HiveRepository _hiveRepository;

  Future<void> init(HiveRepository hiveRepository) async {
    _hiveRepository = hiveRepository;
  }

}
