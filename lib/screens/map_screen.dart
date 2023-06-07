import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofit/constants/routes.dart';
import 'package:gofit/dimensions.dart';
import 'package:gofit/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:gofit/models/product_model/product_model.dart';
import 'package:gofit/provider/app_provider.dart';
import 'package:gofit/widgets/big_text.dart';
import 'package:gofit/widgets/colors.dart';
import 'package:gofit/widgets/icon_and_text_widget.dart';
import 'package:gofit/widgets/small_text.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';

import 'product_details/product_details.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<ProductModel> productModelList = [];
  List<String> categories = [
    "서울대입구역",
    "선릉역",
  ];
  List<String> selectedCategories = [];

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    getClassList();

    // getProductList();
    super.initState();
  }

  void getClassList() async {
    setState(() {
      isLoading = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        title: Text(
          "수업 찾기",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Pretendard',
          ),
        ),
      ),
      body: Stack(
        children: [
          KakaoMap(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 80,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Set the background color of the button
                ),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            20), // Set the desired top corner radius
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20 * 5,
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: productModelList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Routes.instance.push(
                                      widget: ProductDetails(
                                        singleProduct: productModelList[index]!,
                                      ),
                                      context: context,
                                    );
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
                                                productModelList[index].image,
                                              ),
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
                                                right: Dimensions.width10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  BigText(
                                                    text:
                                                        productModelList[index]
                                                            .name,
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Dimensions.height10),
                                                  SmallText(
                                                    text:
                                                        productModelList[index]
                                                            .description,
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Dimensions.height10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      IconAndTextWidget(
                                                        icon: Icons.location_on,
                                                        text: productModelList[
                                                                index]
                                                            .distance,
                                                        iconColor:
                                                            AppColors.mainColor,
                                                      ),
                                                      IconAndTextWidget(
                                                        icon: Icons
                                                            .access_time_rounded,
                                                        text: productModelList[
                                                                index]
                                                            .duration,
                                                        iconColor: AppColors
                                                            .iconColor2,
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
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('목록 보기'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
