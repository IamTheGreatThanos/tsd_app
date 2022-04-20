import '../dio_wrapper/dio_wrapper.dart';
import '../dio_wrapper/side_dio_wrapper.dart';

class NetworkService {
  late final DioWrapper _dioWrapper;
  final SideDioWrapper _sideDioWrapper = SideDioWrapper();
  static const String constToken = '';

  void init(DioWrapper dioService) {
    _dioWrapper = dioService;
  }
}
