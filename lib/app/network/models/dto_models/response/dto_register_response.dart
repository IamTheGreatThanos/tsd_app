// ignore_for_file: avoid_dynamic_calls

class DTORegisterResponse {
  DTORegisterResponse({
      this.accessToken, 
      this.tokenType, 
      this.user,});

  DTORegisterResponse.fromJson(dynamic json) {
    accessToken = json['access_token'] as String;
    tokenType = json['token_type'] as String;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? accessToken;
  String? tokenType;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['token_type'] = tokenType;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.login, 
      this.name, 
      this.phone, 
      this.createdAt, 
      this.id,});

  User.fromJson(dynamic json) {
    login = json['login'] as String;
    name = json['name'] as String;
    phone = json['phone'] as String;
    createdAt = json['created_at'] as String;
    id = json['id'] as int;
  }
  String? login;
  String? name;
  String? phone;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = login;
    map['name'] = name;
    map['phone'] = phone;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}
