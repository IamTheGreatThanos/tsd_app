import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_login_response.dart';
import 'package:pharmacy_arrival/network/models/dto_models/response/dto_register_response.dart';
import 'package:pharmacy_arrival/screens/auth/ui/_vmodel.dart';

import '../dio_wrapper/dio_wrapper.dart';
import '../dio_wrapper/side_dio_wrapper.dart';
import '../models/dto_models/response/dto_move_data.dart';

class NetworkService {
  late final DioWrapper _dioWrapper;
  final SideDioWrapper _sideDioWrapper = SideDioWrapper();
  static const String constToken = '';

  void init(DioWrapper dioService) {
    _dioWrapper = dioService;
  }

  Future<DTORegisterResponse> register(SignInVModel vmodel) async {
    final result = await _dioWrapper.sendRequest(
      path: "/api/register",
      method: NetworkMethod.post,
      formData: FormData.fromMap({
        "name": vmodel.name,
        "login": vmodel.login,
        "password": vmodel.password,
        "phone": vmodel.phone,
      }),
    );
    return DTORegisterResponse.fromJson(result.data);
  }

  Future<DTOLoginResponse> login(SignInVModel vmodel) async {
    final result = await _dioWrapper.sendRequest(
      path: "/api/login",
      method: NetworkMethod.post,
      formData: FormData.fromMap({
        "login": vmodel.login,
        "password": vmodel.password,
      }),
    );
    return DTOLoginResponse.fromJson(result.data);
  }

  Future<DTOLoginResponse> loginQr(String qrToken) async {
    final result = await _dioWrapper.sendRequest(
      path: "/api/login-qr",
      method: NetworkMethod.post,
      formData: FormData.fromMap({
        "qr_token": qrToken,
      }),
    );
    return DTOLoginResponse.fromJson(result.data);
  }

  Future<List<DTOMoveData>> getMoveData() async {
    final result = await _dioWrapper.sendRequest(
      path: "moving-product/1",
      method: NetworkMethod.get,
    );
    return dtoMoveDataFromJson(jsonEncode(result.data));
  }
}
