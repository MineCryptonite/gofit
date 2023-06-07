import 'package:flutter/material.dart';
import 'package:gofit/constants/routes.dart';
import 'package:gofit/dimensions.dart';
import 'package:gofit/screens/favourite_screen/widgets/single_favourite_item.dart';
import 'package:gofit/screens/product_details/product_details.dart';
import 'package:gofit/widgets/big_text.dart';
import 'package:gofit/widgets/colors.dart';
import 'package:gofit/widgets/icon_and_text_widget.dart';
import 'package:gofit/widgets/small_text.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colo,
        title: const Text(
          "찜",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? const Center(
              child: Text("찜한 수업이 없습니다."),
            )
          // : ListView.builder(
          //     itemCount: appProvider.getFavouriteProductList.length,
          //     padding: const EdgeInsets.all(12),
          //     itemBuilder: (ctx, index) {
          //       return SingleFavouriteItem(
          //         singleProduct: appProvider.getFavouriteProductList[index],
          //       );
          //     }),
          : SingleChildScrollView(
              child: ListView.builder(
                padding: EdgeInsets.only(
                    top: Dimensions.height20, bottom: Dimensions.height20 * 5),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: appProvider.getFavouriteProductList.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                          widget: ProductDetails(
                            singleProduct:
                                appProvider.getFavouriteProductList[index]!,
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
                                  BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(appProvider
                                    .getFavouriteProductList[index].image),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                        text: appProvider
                                            .getFavouriteProductList[index]
                                            .name),
                                    SizedBox(height: Dimensions.height10),
                                    SmallText(
                                        text: appProvider
                                            .getFavouriteProductList[index]
                                            .description),
                                    SizedBox(height: Dimensions.height10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: appProvider
                                              .getFavouriteProductList[index]
                                              .distance,
                                          iconColor: AppColors.mainColor,
                                        ),
                                        IconAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: appProvider
                                              .getFavouriteProductList[index]
                                              .duration,
                                          iconColor: AppColors.iconColor2,
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
    );
  }
}
