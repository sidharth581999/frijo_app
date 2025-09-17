// To parse this JSON data, do
//
//     final MyFeedModel = MyFeedModelFromJson(jsonString);

import 'dart:convert';

MyFeedModel MyFeedModelFromJson(String str) => MyFeedModel.fromJson(json.decode(str));

String MyFeedModelToJson(MyFeedModel data) => json.encode(data.toJson());

class MyFeedModel {
    final bool? status;
    final String? message;

    MyFeedModel({
        this.status,
        this.message,

    });

    factory MyFeedModel.fromJson(Map<String, dynamic> json) => MyFeedModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
