// To parse this JSON data, do
//
//     final LoginModel = LoginModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

LoginModel LoginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String LoginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    final bool? status;
    final String? message;
    final String? token;
    final bool? isSuperuser;
    final UserDetails? userDetails;

    LoginModel({
        this.status,
        this.message,
        this.token,
        this.isSuperuser,
        this.userDetails,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        isSuperuser: json["is_superuser"],
        userDetails: json["user_details"] == null ? null : UserDetails.fromJson(json["user_details"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "is_superuser": isSuperuser,
        "user_details": userDetails?.toJson(),
    };
}

class UserDetails {
    final int? id;
    final dynamic lastLogin;
    final String? name;
    final String? phone;
    final String? address;
    final String? mail;
    final String? username;
    final String? password;
    final String? passwordText;
    final int? admin;
    final bool? isAdmin;
    final bool? isActive;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic branch;

    UserDetails({
        this.id,
        this.lastLogin,
        this.name,
        this.phone,
        this.address,
        this.mail,
        this.username,
        this.password,
        this.passwordText,
        this.admin,
        this.isAdmin,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.branch,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        lastLogin: json["last_login"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        mail: json["mail"],
        username: json["username"],
        password: json["password"],
        passwordText: json["password_text"],
        admin: json["admin"],
        isAdmin: json["is_admin"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        branch: json["branch"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "last_login": lastLogin,
        "name": name,
        "phone": phone,
        "address": address,
        "mail": mail,
        "username": username,
        "password": password,
        "password_text": passwordText,
        "admin": admin,
        "is_admin": isAdmin,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "branch": branch,
    };
}
