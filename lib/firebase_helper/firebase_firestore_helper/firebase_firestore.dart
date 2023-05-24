// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:gofit/constants/constants.dart';
import 'package:gofit/models/category_model/category_model.dart';
import 'package:gofit/models/home_model.dart';
import 'package:gofit/models/order_model/order_model.dart';
import 'package:gofit/models/product_model/product_model.dart';
import 'package:gofit/models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("workoutCategories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      //print(categoriesList);

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<List<ProductModel>>> getHome() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot1 =
          await _firebaseFirestore.collection("home").get();

      List<HomeModel> homeList =
          querySnapshot1.docs.map((e) => HomeModel.fromJson(e.data())).toList();

      List<List<String>> classesLists = [];
      List<String> classes = [];
      for (int i = 0; i < homeList.length; i++) {
        for (int j = 0; j < homeList[i].classesRef.length; j++) {
          String value = homeList[i].classesRef[j].toString();
          List<String> temp = value.split('/');
          //print(temp[1]);
          classes.add(temp[1]);
        }
        classesLists.add(classes);
        classes = [];
      }

      //print(classesLists);

      List<ProductModel> homeClassList = [];
      List<List<ProductModel>> homeClassesList = [];
      for (int i = 0; i < classesLists.length; i++) {
        for (int j = 0; j < classesLists[i].length; j++) {
          String classesList = classesLists[i][j];
          print(classesList);
          QuerySnapshot<Map<String, dynamic>> querySnapshot =
              await FirebaseFirestore.instance
                  .collection("classes")
                  .where("id", isEqualTo: classesList)
                  .get();

          if (querySnapshot.docs.isNotEmpty) {
            print("ITS WORKING");
            QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                querySnapshot.docs[0];
            Map<String, dynamic> data = documentSnapshot.data();
            ProductModel productModel = ProductModel.fromJson(data);
            homeClassList.add(productModel);
          }
        }

        //print(homeClassList);
        homeClassesList.add(homeClassList);
        homeClassList = []; // Clear the list for the next iteration
      }
      print(homeClassesList);

      return homeClassesList;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());

      return [];
    }
  }

  /*Future<List<List<ProductModel>>> getHomeClasses(List<HomeModel> homeList) async {
    try {
      List<List<String>> classesLists = [];
      List<String> classes = [];
      for (int i = 0; i < homeList.length; i++) {
        for (int j = 0; j < homeList[i].classesRef.length; j++) {
          String value = homeList[i].classesRef[j].toString();
          List<String> temp = value.split('/');
          //print(temp[1]);
          classes.add(temp[1]);
        }
        classesLists.add(classes);
        classes = [];
      }

      List<ProductModel> homeClassList = [];
      List<List<ProductModel>> homeClassesList = [];
      for (int i = 0; i < classesLists.length; i++) {
        for (int j = 0; j < classesLists[0][j].length; j++) {
          String classesList = classesLists[0][j];
          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection('home')
              .doc(classesList)
              .get();
          if (documentSnapshot.exists) {
            Map<String, dynamic> data =
                documentSnapshot.data() as Map<String, dynamic>;
            ProductModel productModel = ProductModel.fromJson(data);
            homeClassList.add(productModel);
          }
        }
        homeClassesList.add(homeClassList);
      }

      return homeClassesList;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());

      return [];
    }
  }*/

  Future<List<ProductModel>> getBestProducts() async {
    try {
      _firebaseFirestore
          .collection("classes")
          .get()
          .then((res) => print(res.size));
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("classes").get();
      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("workoutCategories").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

  /*Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list, BuildContext context, String payment) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.creditsRequired;
      }
      DocumentReference documentReference = _firebaseFirestore
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc();
      DocumentReference admin = _firebaseFirestore.collection("orders").doc();

      admin.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": admin.id,
      });
      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status": "Pending",
        "totalPrice": totalPrice,
        "payment": payment,
        "orderId": documentReference.id,
      });
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Ordered Successfully");
      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }*/

  ////// Get Order User//////

  /*Future<List<OrderModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("usersOrders")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("orders")
              .get();

      List<OrderModel> orderList = querySnapshot.docs
          .map((element) => OrderModel.fromJson(element.data()))
          .toList();

      return orderList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }*/

  void updateTokenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "notificationToken": token,
      });
    }
  }
}
