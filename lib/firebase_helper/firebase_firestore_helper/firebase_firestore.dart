// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:gofit/constants/constants.dart';
import 'package:gofit/models/category_model/category_model.dart';
import 'package:gofit/models/class_details_model.dart';
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

  Future<List<List<ProductModel>>> getHomeClasses() async {
    try {
      CollectionReference homeCollection =
          _firebaseFirestore.collection('home');
      List<List<ProductModel>> homeClassesList = [];

      QuerySnapshot homeSnapshot = await homeCollection.get();

      List<Future<List<ProductModel>>> fetchProductsFutures =
          homeSnapshot.docs.map((homeDoc) {
        Map<String, dynamic> data = homeDoc.data() as Map<String, dynamic>;
        List<DocumentReference> references =
            List<DocumentReference>.from(data['classesRef']);

        List<Future<ProductModel>> fetchProductFutures = references.map((ref) {
          return ref.get().then((productDoc) {
            if (productDoc.exists) {
              Map<String, dynamic> productData =
                  productDoc.data() as Map<String, dynamic>;
              return ProductModel.fromJson(productData);
            } else {
              throw Exception('Referenced product document does not exist.');
            }
          });
        }).toList();

        return Future.wait(fetchProductFutures);
      }).toList();

      List<List<ProductModel>> productsList =
          await Future.wait(fetchProductsFutures);

      for (List<ProductModel> products in productsList) {
        homeClassesList.add(products);
      }

      return homeClassesList;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());

      return [];
    }
  }

  Future<List<HomeModel>> getHomeList() async {
    List<HomeModel> homeList = [];

    return homeList;
  }

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

  Future<List<ProductModel?>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('classes')
          .where("exerciseType", isEqualTo: id)
          .get();

      List<ProductModel?> productModels =
          querySnapshot.docs.map((documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          return ProductModel.fromJson(data);
        }
        return null;
      }).toList();

      // Remove any null values from the list
      productModels.removeWhere((productModel) => productModel == null);

      return productModels;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
    print(querySnapshot.data());

    return UserModel.fromJson(querySnapshot.data()!);
  }

  /*Future<ClassDetailsModel?> getClassDetailsFromClasses(
      ProductModel classModel) async {
    try {
      CollectionReference classDetailsCollection =
          _firebaseFirestore.collection('classDetails');

      // Query the 'classDetails' collection to retrieve all documents
      QuerySnapshot classDetailsSnapshot = await classDetailsCollection.get();

      if (classDetailsSnapshot.docs.isNotEmpty) {
        // Iterate through each classDetails document
        for (DocumentSnapshot classDetailsDoc in classDetailsSnapshot.docs) {
          // Get the reference field that indicates which class the document belongs to
          DocumentReference classReference = classDetailsDoc['classRef'];

          // Get the reference path of the class document
          String classPath = classReference.path;

          // Check if the class document's path matches the reference path of the given ClassModel
          if (classPath == classModel.reference.path) {
            // Fetch the corresponding class document using the reference
            DocumentSnapshot classDoc = await classReference.get();

            if (classDoc.exists) {
              Map<String, dynamic> classData =
                  classDoc.data() as Map<String, dynamic>;
              // Assuming you have a ClassDetailsModel class to represent the class details
              ClassDetailsModel classDetailsModel =
                  ClassDetailsModel.fromJson(classData);
              return classDetailsModel;
            } else {
              throw Exception(
                  'Referenced class document does not exist for classDetails document: ${classDetailsDoc.id}');
            }
          }
        }
        throw Exception(
            'No matching classDetails found for the given ClassModel.');
      } else {
        throw Exception('No classDetails documents found.');
      }
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());
      return null;
    }
  }*/
  Future<void> updateClassDocumentsWithClassDetails() async {
    try {
      // Retrieve the documents from the 'classes' collection
      QuerySnapshot classesSnapshot =
          await _firebaseFirestore.collection('classes').get();

      // Iterate over each class document
      for (DocumentSnapshot classDoc in classesSnapshot.docs) {
        // Get the class ID
        String classId = classDoc.id;

        // Get the 'classDetails' collection reference within the class document
        CollectionReference classDetailsCollection =
            classDoc.reference.collection('classDetails');

        // Retrieve the documents from the 'classDetails' collection
        QuerySnapshot classDetailsSnapshot = await classDetailsCollection.get();

        // Iterate over each classDetails document
        for (DocumentSnapshot classDetailsDoc in classDetailsSnapshot.docs) {
          // Get the data from the classDetailsDoc document
          Map<String, dynamic> classDetailsData =
              classDetailsDoc.data() as Map<String, dynamic>;

          // Update the class document with the classDetailsData
          await classDoc.reference.update(classDetailsData);

          print('Class document updated with classDetails: $classId');
        }
      }
    } catch (e) {
      print('Error updating class documents with classDetails: $e');
    }
  }

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
