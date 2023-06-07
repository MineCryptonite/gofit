import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ReservationModel reservationModelFromJson(String str) =>
    ReservationModel.fromJson(json.decode(str));

String reservationModelToJson(ReservationModel data) =>
    json.encode(data.toJson());

class ReservationModel {
  ReservationModel({
    required this.className,
    required this.classRequiredCredits,
    required this.createdAt,
    required this.date,
    required this.isFinal,
    required this.startTime,
    required this.time,
    required this.timeSlot,
    required this.user,
  });
  String className;
  int classRequiredCredits;
  Timestamp createdAt;
  String date;
  bool isFinal;
  Timestamp startTime;
  String time;
  dynamic timeSlot;
  dynamic user;

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        className: json['className'] ?? "",
        classRequiredCredits: json['businessHours'] ?? 0,
        createdAt: json['createdAt'] ?? null,
        date: json['date'] ?? "",
        isFinal: json['isFinal'] ?? false,
        startTime: json['startTime'] ?? null,
        time: json['time'] ?? "",
        timeSlot: json['timeSlot'] ?? "",
        user: json['user'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "classRequiredCredits": classRequiredCredits,
        "createdAt": createdAt,
        "date": date,
        "isFinal": isFinal,
        "startTime": startTime,
        "time": time,
        "timeSlot": timeSlot,
        "user": user,
      };
  // ProductModel copyWith({
  //   int? qty,
  // }) =>
  //     ProductModel(
  //       image: image,
  //       coords: coords,
  //       creditsRequired: creditsRequired,
  //       distance: distance,
  //       exerciseType: exerciseType,
  //       locationFilter: locationFilter,
  //       name: name,
  //       originalPrice: originalPrice,
  //       paymentUrl: paymentUrl,
  //       isFavourite: isFavourite,
  //     );
}
