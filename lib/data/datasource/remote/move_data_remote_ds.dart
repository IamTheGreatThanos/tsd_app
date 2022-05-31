
import 'package:dio/dio.dart';

abstract class MoveDataRemoteDS {

}

class MoveDataRemoteDSImpl extends MoveDataRemoteDS {
  final Dio dio;
  MoveDataRemoteDSImpl(this.dio);


}
