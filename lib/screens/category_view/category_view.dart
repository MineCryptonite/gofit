import 'package:flutter/material.dart';
import 'package:gofit/dimensions.dart';
import 'package:gofit/widgets/big_text.dart';
import 'package:gofit/widgets/colors.dart';
import 'package:gofit/widgets/icon_and_text_widget.dart';
import 'package:gofit/widgets/small_text.dart';

import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../../models/category_model/category_model.dart';
import '../../models/product_model/product_model.dart';
import '../product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel?> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.category);
    //productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight * 1),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const BackButton(),
                        Text(
                          widget.categoryModel.category,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Best Product is empty"),
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: 100),
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: Dimensions.height20),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productModelList.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Routes.instance.push(
                                      widget: ProductDetails(
                                        singleProduct: productModelList[index]!,
                                      ),
                                      context: context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20,
                                    bottom: Dimensions.height10,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Dimensions.listViewImgSize,
                                        height: Dimensions.listViewImgSize,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white38,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                productModelList[index]!.image),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: Dimensions.listViewImgSize,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  Dimensions.radius20),
                                              bottomRight: Radius.circular(
                                                  Dimensions.radius20),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Dimensions.width10,
                                                right: Dimensions.width10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                BigText(
                                                    text:
                                                        productModelList[index]!
                                                            .name),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height10),
                                                SmallText(text: "TESTING"),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconAndTextWidget(
                                                      icon: Icons.circle_sharp,
                                                      text: "Normal",
                                                      iconColor:
                                                          AppColors.iconColor1,
                                                    ),
                                                    IconAndTextWidget(
                                                      icon: Icons.location_on,
                                                      text: "1.7km",
                                                      iconColor:
                                                          AppColors.mainColor,
                                                    ),
                                                    IconAndTextWidget(
                                                      icon: Icons
                                                          .access_time_rounded,
                                                      text: "32min",
                                                      iconColor:
                                                          AppColors.iconColor2,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
    );
  }
}
