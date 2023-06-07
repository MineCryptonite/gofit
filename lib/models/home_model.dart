import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    required this.classesRef,
    required this.title,
  });

  List<dynamic> classesRef;
  String title;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        classesRef: json["classesRef"] ?? [],
        title: json["title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "classesRef": classesRef,
        "title": title,
      };
}
