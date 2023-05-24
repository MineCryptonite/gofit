import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.imageUrl,
    required this.category,
    required this.priority,
  });

  String imageUrl;
  String category;
  int priority;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        imageUrl: json["imageUrl"],
        category: json["category"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "category": category,
        "priority": priority,
      };
}
