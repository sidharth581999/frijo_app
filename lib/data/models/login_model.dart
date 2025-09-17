// To parse this JSON data, do
//
//     final LoginModel = LoginModelFromJson(jsonString);

import 'dart:convert';

LoginModel LoginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String LoginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool? status;
    bool? privilage;
    Token? token;
    String? phone;

    LoginModel({
        this.status,
        this.privilage,
        this.token,
        this.phone,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        privilage: json["privilage"],
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "privilage": privilage,
        "token": token?.toJson(),
        "phone": phone,
    };
}

class Token {
    String? refresh;
    String? access;

    Token({
        this.refresh,
        this.access,
    });

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        refresh: json["refresh"],
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
    };
}
