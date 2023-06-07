import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ClassAvailableTimeSlotsModel classAvailableTimeSlotModelFromJson(String str) =>
    ClassAvailableTimeSlotsModel.fromJson(json.decode(str));

String classAvailableTimeSlotModelToJson(ClassAvailableTimeSlotsModel data) =>
    json.encode(data.toJson());

class ClassAvailableTimeSlotsModel {
  ClassAvailableTimeSlotsModel({
    required this.endTime,
    required this.maxHourBeforeClass,
    required this.maxLimit,
    required this.minHoursBeforeClass,
    required this.minHoursToCancel,
    required this.startTime,
    required this.weekdays,
  });
  String endTime;
  int maxHourBeforeClass;
  int maxLimit;
  int minHoursBeforeClass;
  int minHoursToCancel;
  String startTime;
  List<dynamic> weekdays;

  factory ClassAvailableTimeSlotsModel.fromJson(Map<String, dynamic> json) =>
      ClassAvailableTimeSlotsModel(
        endTime: json['endTime'] ?? "",
        maxHourBeforeClass: json['maxHourBeforeClass'] ?? 0,
        maxLimit: json['maxLimit'] ?? 0,
        minHoursBeforeClass: json['minHoursBeforeClass'] ?? 0,
        minHoursToCancel: json['minHoursToCancel'] ?? 0,
        startTime: json['startTime'] ?? "",
        weekdays: json['weekdays'] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "endTime": endTime,
        "maxHourBeforeClass": maxHourBeforeClass,
        "maxLimit": maxLimit,
        "minHoursBeforeClass": minHoursBeforeClass,
        "minHoursToCancel": minHoursToCancel,
        "startTime": startTime,
        "weekdays": weekdays,
      };
}
