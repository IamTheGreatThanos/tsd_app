///base request model
abstract class Encodable {
  Map<String, dynamic> toJson();
}

class SimpleEncodable implements Encodable {
  final Map<String, dynamic> map;

  SimpleEncodable(this.map);

  @override
  Map<String, dynamic> toJson() {
    return map;
  }
}
