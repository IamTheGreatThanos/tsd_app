// ignore_for_file: avoid_dynamic_calls

class DTOLoginResponse {
  DTOLoginResponse({
      this.accessToken, 
      this.tokenType, 
      this.user,});

  DTOLoginResponse.fromJson(dynamic json) {
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
      this.id, 
      this.name, 
      this.login, 
      this.phone, 
      this.birthday, 
      this.startJob, 
      this.scheduleWork, 
      this.iin, 
      this.avatar, 
      this.status, 
      this.position, 
      this.groupWarehouse, 
      this.administrator, 
      this.createdAt,});

  User.fromJson(dynamic json) {
    id = json['id'] as int;
    name = json['name'] as String;
    login = json['login'] as String;
    phone = json['phone'] as String;
    birthday = json['birthday'];
    startJob = json['start_job'];
    scheduleWork = json['schedule_work'];
    iin = json['iin'];
    avatar = json['avatar'] as String;
    status = json['status'];
    position = json['position'];
    groupWarehouse = json['group_warehouse'];
    administrator = json['administrator'] as int;
    createdAt = json['created_at'] as String;
  }
  int? id;
  String? name;
  String? login;
  String? phone;
  dynamic birthday;
  dynamic startJob;
  dynamic scheduleWork;
  dynamic iin;
  String? avatar;
  dynamic status;
  dynamic position;
  dynamic groupWarehouse;
  int? administrator;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['login'] = login;
    map['phone'] = phone;
    map['birthday'] = birthday;
    map['start_job'] = startJob;
    map['schedule_work'] = scheduleWork;
    map['iin'] = iin;
    map['avatar'] = avatar;
    map['status'] = status;
    map['position'] = position;
    map['group_warehouse'] = groupWarehouse;
    map['administrator'] = administrator;
    map['created_at'] = createdAt;
    return map;
  }

}
