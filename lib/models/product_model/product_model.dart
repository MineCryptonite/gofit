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
  });
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
        image: json["image"],
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
