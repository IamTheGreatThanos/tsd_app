
import 'package:dio/dio.dart';
import 'package:pharmacy_arrival/app/generated/l10n.dart';


extension DioErrorUtils on Object {
  String get dioErrorMessage {
    var output = S.current.errorGeneral;
    if (this is! DioError) return output;
    final error = this as DioError;
    final List errorsList = [error.response?.data['message']];
    if (errorsList == null) return output;
    if (errorsList.isNotEmpty) {
      output = errorsList.first.toString();
    }
    return output;
  }

  int? get dioErrorStatusCode {
    int? output;
    if (this is! DioError) return output;
    return (this as DioError).response?.statusCode;
  }
}
