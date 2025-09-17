// To parse this JSON data, do
//
//     final HomeDataModel = HomeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel HomeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String HomeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
    final bool? status;
    final String? message;


    HomeDataModel({
        this.status,
        this.message,

    });

    factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        status: json["status"],
        message: json["message"],
      
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    
    };
}
