class LoginRequestEntity {
  String? email;
  String? password;

  LoginRequestEntity({this.email, this.password});

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class UserLoginResponseEntity {
  int? code;
  String? msg;
  UserProfileModel? data;

  UserLoginResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) => UserLoginResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: UserProfileModel.fromJson(json["data"]),
      );
}

// login result
class UserProfileModel {
  String id;
  String email;

  UserProfileModel({
    required this.id,
    required this.email,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
      };
}