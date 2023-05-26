import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofit/constants/routes.dart';
import 'package:gofit/dimensions.dart';
import 'package:gofit/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:gofit/models/category_model/category_model.dart';
import 'package:gofit/models/home_model.dart';
import 'package:gofit/provider/app_provider.dart';
import 'package:gofit/screens/category_view/category_view.dart';
import 'package:gofit/screens/product_details/product_details.dart';
import 'package:gofit/widgets/big_text.dart';
import 'package:gofit/widgets/colors.dart';
import 'package:gofit/widgets/icon_and_text_widget.dart';
import 'package:gofit/widgets/small_text.dart';
import 'package:gofit/widgets/top_titles/top_titles.dart';
import 'package:provider/provider.dart';

import '../../models/product_model/product_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  List<List<ProductModel>> homeClassesList = [];
  List<HomeModel> homeList = [];
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    getCategoryList();

    // getProductList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    homeClassesList = await FirebaseFirestoreHelper.instance.getHomeClasses();

    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    homeList = await FirebaseFirestoreHelper.instance.getHomeList();
    // print(homeClassesList);
    //productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 64.0,
                        ),
                        BigText(
                          text: "검색",
                          size: 24,
                        ),
                        // const TopTitles(subtitle: "", title: "GoFit"),
                        // Text(
                        //   'GoFit',
                        //   style: TextStyle(
                        //     fontFamily: 'Pretendard',
                        //     fontSize: 50,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 14.0,
                        ),

                        TextFormField(
                          controller: search,
                          onChanged: (String value) {
                            searchProducts(value);
                          },
                          decoration: const InputDecoration(hintText: ""),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        BigText(
                          text: "종류별",
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Categories is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget:
                                                CategoryView(categoryModel: e),
                                            context: context);
                                      },
                                      child: Card(
                                          color: Colors.white,
                                          elevation: 3.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            margin: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            decoration: BoxDecoration(
                                              image: new DecorationImage(
                                                image: new NetworkImage(
                                                    e.imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )

                                          // SizedBox(
                                          //   height: 60,
                                          //   width: 60,
                                          //   child: Image.network(e.imageUrl),
                                          // ),
                                          ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, left: 12.0),
                    child: BigText(
                      text: "인기",
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  homeClassesList.isNotEmpty
                      ? ClassWidget(
                          pageController: pageController,
                          classes: homeClassesList[0],
                          currPageValue: _currPageValue,
                          scaleFactor: _scaleFactor,
                          height: _height,
                        )
                      : Container(
                          child: Text("LOADING"),
                        ),
                  Center(
                    child: DotsIndicator(
                      dotsCount: homeClassesList.isEmpty
                          ? 1
                          : homeClassesList[0].length,
                      position: _currPageValue,
                      decorator: DotsDecorator(
                        activeColor: AppColors.mainColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  !isSearched()
                      ? Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 12.0),
                          child: BigText(
                            text: "전체",
                          ),
                        )
                      : SizedBox.fromSize(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? const Center(
                          child: Text("No Product Found"),
                        )
                      : searchList.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.only(bottom: 100),
                              child: ListView.builder(
                                padding:
                                    EdgeInsets.only(top: Dimensions.height20),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: searchList.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Routes.instance.push(
                                          widget: ProductDetails(
                                            singleProduct: searchList[index]!,
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white38,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    searchList[index].image),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height:
                                                  Dimensions.listViewImgSize,
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
                                                        text: searchList[index]
                                                            .name),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .height10),
                                                    SmallText(
                                                        text: searchList[index]
                                                            .description),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .height10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        IconAndTextWidget(
                                                          icon:
                                                              Icons.location_on,
                                                          text:
                                                              searchList[index]
                                                                  .distance,
                                                          iconColor: AppColors
                                                              .mainColor,
                                                        ),
                                                        IconAndTextWidget(
                                                          icon: Icons
                                                              .access_time_rounded,
                                                          text:
                                                              searchList[index]
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
                                }),
                              ),
                            )
                          : productModelList.isEmpty
                              ? const Center(
                                  child: Text("Best Product is empty"),
                                )
                              : Container(
                                  margin: EdgeInsets.only(bottom: 100),
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height20),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: productModelList.length,
                                    itemBuilder: ((context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Routes.instance.push(
                                              widget: ProductDetails(
                                                singleProduct:
                                                    productModelList[index]!,
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
                                                width:
                                                    Dimensions.listViewImgSize,
                                                height:
                                                    Dimensions.listViewImgSize,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white38,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        productModelList[index]
                                                            .image),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: Dimensions
                                                      .listViewImgSize,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight: Radius.circular(
                                                          Dimensions.radius20),
                                                      bottomRight:
                                                          Radius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        BigText(
                                                            text:
                                                                productModelList[
                                                                        index]
                                                                    .name),
                                                        SizedBox(
                                                            height: Dimensions
                                                                .height10),
                                                        SmallText(
                                                            text: productModelList[
                                                                    index]
                                                                .description),
                                                        SizedBox(
                                                            height: Dimensions
                                                                .height10),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            IconAndTextWidget(
                                                              icon: Icons
                                                                  .location_on,
                                                              text:
                                                                  productModelList[
                                                                          index]
                                                                      .distance,
                                                              iconColor:
                                                                  AppColors
                                                                      .mainColor,
                                                            ),
                                                            IconAndTextWidget(
                                                              icon: Icons
                                                                  .access_time_rounded,
                                                              text:
                                                                  productModelList[
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

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

class ClassWidget extends StatelessWidget {
  const ClassWidget({
    super.key,
    required this.pageController,
    required this.classes,
    required double currPageValue,
    required double scaleFactor,
    required double height,
  })  : _currPageValue = currPageValue,
        _scaleFactor = scaleFactor,
        _height = height;

  final PageController pageController;
  final List<ProductModel> classes;
  final double _currPageValue;
  final double _scaleFactor;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //color: Colors.redAccent,
          height: Dimensions.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: classes.length,
            itemBuilder: (context, position) {
              Matrix4 matrix = new Matrix4.identity();
              if (position == _currPageValue.floor()) {
                var currScale =
                    1 - (_currPageValue - position) * (1 - _scaleFactor);
                var currTrans = _height * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              } else if (position == _currPageValue.floor() + 1) {
                var currScale = _scaleFactor +
                    (_currPageValue - position + 1) * (1 - _scaleFactor);
                var currTrans = _height * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1);
                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              } else if (position == _currPageValue.floor() - 1) {
                var currScale =
                    1 - (_currPageValue - position) * (1 - _scaleFactor);
                var currTrans = _height * (1 - currScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currScale, 1);
                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, currTrans, 0);
              } else {
                var currScale = 0.8;
                matrix = Matrix4.diagonal3Values(1, currScale, 1)
                  ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
              }

              return Transform(
                transform: matrix,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Routes.instance.push(
                            widget: ProductDetails(
                              singleProduct: classes[position]!,
                            ),
                            context: context);
                      },
                      child: Container(
                        height: Dimensions.pageViewContainer,
                        margin: EdgeInsets.only(
                            left: Dimensions.width10,
                            right: Dimensions.width10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          color: position.isEven
                              ? Color(0xFF69c5df)
                              : Color(0xFF9294cc),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(classes[position].image)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: Dimensions.pageViewTextContainer,
                        margin: EdgeInsets.only(
                            left: Dimensions.width30,
                            right: Dimensions.width30,
                            bottom: Dimensions.height30),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFe8e8e8),
                              blurRadius: 5.0,
                              offset: Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-5, 0),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(5, 0),
                            )
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height15,
                              left: Dimensions.width15,
                              right: Dimensions.width15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                  text: classes[position].name,
                                  size: Dimensions.font26),
                              //SizedBox(height: Dimensions.height10),
                              SizedBox(height: Dimensions.height20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndTextWidget(
                                    icon: Icons.location_on,
                                    text: classes[position].distance,
                                    iconColor: AppColors.mainColor,
                                  ),
                                  IconAndTextWidget(
                                    icon: Icons.access_time_rounded,
                                    text: "60분",
                                    iconColor: AppColors.iconColor2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
