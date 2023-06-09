import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.photo_url,
    this.phone_number,
    required this.uid,
    required this.display_name,
    required this.email,
    required this.created_time,
    required this.referralCode,
    required this.referralCount,
  });

  String? photo_url;
  String display_name;
  String email;
  String? phone_number;
  String uid;
  Timestamp created_time;
  String referralCode;
  int referralCount;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["uid"],
      photo_url: json["photo_url"],
      email: json["email"],
      display_name: json["display_name"] ?? "",
      phone_number: json["phone_number"],
      created_time: json["created_time"],
      referralCode: json["referralCode"],
      referralCount: json["referralCount"]);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photo_url": photo_url,
        "email": email,
        "display_name": display_name,
        "phone_number": phone_number,
        "created_time": created_time,
        "referralCode": referralCode,
        "referralCount": referralCount,
      };

  UserModel copyWith({String? name, image, phone_number}) => UserModel(
        uid: uid,
        display_name: name ?? display_name,
        email: email,
        photo_url: image ?? photo_url,
        phone_number: phone_number ?? this.phone_number,
        created_time: created_time,
        referralCode: referralCode,
        referralCount: referralCount,
      );
}
