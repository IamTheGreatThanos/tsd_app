import 'package:dio/dio.dart';

import '../../generated/l10n.dart';
import 'error_handler_constants.dart';

class ErrorHandler {
  late final S _lang;

  ErrorHandler();

  void initialize(S lang) {
    _lang = lang;
  }

  String handleError(error, {ErrorAction? action}) {
    try {
      if (error is DioError) {
        int responseCode = error.response?.statusCode ?? 9999;
        String errorMessage = error.response?.data['message'] as String? ?? '';
        if (error.type == DioErrorType.receiveTimeout || error.type == DioErrorType.connectTimeout) {
          return _lang.server_is_not_reachable;
        }
        else if (error.type == DioErrorType.response) {
          // if (responseCode == ErrorHandlerConstants.unauthorized) {
          //   return _lang.wrong_data_auth;
          // }
          // if (responseCode == ErrorHandlerConstants.badRequest) {
          //   if (errorMessage.contains(_lang.user_not_found) && action == null) {
          //     return _lang.user_with_specified_email_not_found;
          //   }
          //   if (errorMessage.contains(_lang.user_exists)) {
          //     return _lang.user_already_exists;
          //   }
          //   if (errorMessage.contains(_lang.this_email_is_confirmed)) {
          //     return _lang.this_email_has_already_been_verified;
          //   }
          //   if (errorMessage.contains(_lang.this_invite_is_activated)) {
          //     return _lang.this_invitation_has_already_been_used;
          //   }
          //   if (errorMessage.contains(_lang.user_not_found) && action == ErrorAction.verifyEmail) {
          //     return _lang.wrong_confirmation_code;
          //   }
          // }
          // if (responseCode == ErrorHandlerConstants.notEnoughRights) {
          //   return _lang.you_do_not_have_sufficient_rights +
          //       (error.response?.requestOptions.path ?? '');
          // }
          // if (responseCode == ErrorHandlerConstants.notFound) {
          //   if (errorMessage.contains(ErrorHandlerConstants.userNotFound)) {
          //     return _lang.user_not_found;
          //   }
          // }
          // if (responseCode == ErrorHandlerConstants.badGateway) {
          //   if (errorMessage.contains(ErrorHandlerConstants.authCodeConfirm)) {
          //     return _lang.wrong_confirmation_code;
          //   }
          // }
        }
        else {
          return _lang.problem_connecting_to_the_server;
        }
      }
    } catch (e) {
      print(e);
    }
    return error.toString();
  }
}

enum ErrorAction {
  verifyEmail,
}
