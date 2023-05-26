import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.coords,
    required this.creditsRequired,
    required this.distance,
    required this.exerciseType,
    required this.locationFilter,
    required this.hideClass,
    required this.priority,
    required this.ratings,
    required this.name,
    required this.originalPrice,
    required this.paymentUrl,
    required this.isFavourite,
    required this.address,
    required this.businessHours,
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
  List<dynamic> businessHours;
  String description;
  String duration;
  bool hasShower;
  List<dynamic> images;
  List<dynamic> info;
  String instagram;
  int monthlyLimit;
  String requirements;
  String website;
  GeoPoint coords;
  int creditsRequired;
  String distance;
  String exerciseType;
  bool hideClass;
  String image;
  String locationFilter;
  String name;
  int originalPrice;
  String paymentUrl;
  int priority;
  int ratings;
  bool isFavourite;

  //int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        image: json["image"] ?? "",
        coords: json["coords"] ?? GeoPoint(0, 0),
        creditsRequired: json["creditsRequired"] ?? 0,
        distance: json["distance"] ?? "",
        exerciseType: json["exerciseType"] ?? "",
        locationFilter: json["locationFilter"] ?? "",
        name: json["name"] ?? "",
        originalPrice: json["originalPrice"] ?? 0,
        paymentUrl: json["paymentUrl"] ?? "",
        isFavourite: false,
        hideClass: json["hideClass"] ?? false,
        priority: json["priority"] ?? 0,
        ratings: json["ratings"] ?? 0,
        address: json["address"] ?? "",
        businessHours: json["businessHours"] ?? [],
        description: json["description"] ?? "",
        duration: json["duration"] ?? "",
        hasShower: json["hasShower"] ?? false,
        images: json["images"] ?? [],
        info: json["info"] ?? [],
        instagram: json["instagram"] ?? "",
        monthlyLimit: json["monthlyLimit"] ?? 0,
        requirements: json["requirements"] ?? "",
        website: json["website"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "coords": coords,
        "creditsRequired": creditsRequired,
        "distance": distance,
        "exerciseType": exerciseType,
        "locationFilter": locationFilter,
        "name": name,
        "originalPrice": originalPrice,
        "paymentUrl": paymentUrl,
        "hideClass": hideClass,
        "priority": priority,
        "ratings": ratings,
        "address": address,
        "businessHours": businessHours,
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
