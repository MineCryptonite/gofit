import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ClassDetailsModel classDetailsModelFromJson(String str) =>
    ClassDetailsModel.fromJson(json.decode(str));

String classDetailsModelToJson(ClassDetailsModel data) =>
    json.encode(data.toJson());

class ClassDetailsModel {
  ClassDetailsModel({
    required this.address,
    required this.businessHours,
    required this.classRef,
    required this.description,
    required this.duration,
    required this.hasShower,
    required this.images,
    required this.info,
    required this.instagram,
    required this.monthlyLimit,
    required this.requirements,
    required this.website,
  });
  String address;
  List<String> businessHours;
  List<dynamic> classRef;
  String description;
  String duration;
  bool hasShower;
  List<String> images;
  List<String> info;
  String instagram;
  int monthlyLimit;
  String requirements;
  String website;

  factory ClassDetailsModel.fromJson(Map<String, dynamic> json) =>
      ClassDetailsModel(
          address: json['address'] ?? "",
          businessHours: json['businessHours'] ?? [],
          classRef: json['classRef'] ?? [],
          description: json['description'] ?? "",
          duration: json['duration'] ?? "",
          hasShower: json['hasShower'] ?? false,
          images: json['images'] ?? [],
          info: json['info'] ?? [],
          instagram: json['instagram'] ?? "",
          monthlyLimit: json['monthlyLimit'] ?? 0,
          requirements: json['requirements'] ?? "",
          website: json['website'] ?? "");

  Map<String, dynamic> toJson() => {
        "address": address,
        "businessHours": businessHours,
        "classRef": classRef,
        "description": description,
        "duration": duration,
        "hasShower": hasShower,
        "images": images,
        "info": info,
        "instagram": instagram,
        "monthlyLimit": monthlyLimit,
        "requirements": requirements,
        "website": website,
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
