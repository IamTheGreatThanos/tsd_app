// ignore_for_file: constant_identifier_names, void_checks
import 'dart:developer';

import 'package:pharmacy_arrival/core/error/excepteion.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO Локальная ДС для сохранение элементов от блока прием контейнеров
abstract class AcceptContainersLocalDs {
  Future<String> getContainerNumberFromCache();

  Future<void> saveContainerNumberToCache({
    required String containerNumber,
  });

  Future<void> deleteContainerNumberFromCache();
}

const CONT_NUMBER_CACHE = 'CONT_NUMBER';

class AcceptContainersLocalDsImpl extends AcceptContainersLocalDs {
  final SharedPreferences sharedPreferences;

  AcceptContainersLocalDsImpl(this.sharedPreferences);

  @override
  Future<void> deleteContainerNumberFromCache() async {
    log('Delete Container Number from Cache');
    await sharedPreferences.remove(CONT_NUMBER_CACHE);
  }

  @override
  Future<String> getContainerNumberFromCache() async {
    final contNumber = sharedPreferences.getString(CONT_NUMBER_CACHE);
    if (contNumber != null && contNumber.isNotEmpty) {
      log('Get Container Number from Cache: $contNumber');
      return contNumber;
    } else {
      throw CacheException(message: 'В кэше нет запрашиваемые данные');
    }
  }

  @override
  Future<void> saveContainerNumberToCache({
    required String containerNumber,
  }) async {
    log('Set Container Number from Cache: $containerNumber');
    await sharedPreferences.setString(CONT_NUMBER_CACHE, containerNumber);
  }
}
