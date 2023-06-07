import 'package:auto_size_text/auto_size_text.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gofit/constants/constants.dart';
import 'package:gofit/constants/routes.dart';
import 'package:gofit/expandable_text_widget.dart';
import 'package:gofit/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:gofit/models/class_available_time_slots_model.dart';
import 'package:gofit/models/product_model/product_model.dart';
import 'package:gofit/provider/app_provider.dart';
import 'package:gofit/screens/cart_screen/cart_screen.dart';
import 'package:gofit/screens/home/home.dart';
import 'package:gofit/widgets/big_text.dart';
import 'package:gofit/widgets/colors.dart';
import 'package:gofit/widgets/icon_and_text_widget.dart';
import 'package:gofit/widgets/primary_button/primary_button.dart';
import 'package:gofit/widgets/small_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../dimensions.dart';
import '../check_out/check_out.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<ClassAvailableTimeSlotsModel> timeSlotsModels = [];
  List<String> timeSlots = [];
  List<dynamic> weekdays = [];
  List<ClassAvailableTimeSlotsModel> matchingTimeSlots = [];
  ClassAvailableTimeSlotsModel? selectedTimeSlot;

  NumberFormat formatter = NumberFormat('#,##0');

  bool isLoading = false;

  int qty = 1;
  int selectedIndex = -1;

  void handleContainerClick(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getClassAvailableTimeSlotsModels();
  }

  void getClassAvailableTimeSlotsModels() async {
    setState(() {
      isLoading = true;
    });
    timeSlotsModels = await FirebaseFirestoreHelper.instance
        .getClassAvailableTimeSlotsModels(widget.singleProduct);
    // timeSlots = timeSlotsModels.map((model) => model.startTime).toList();
    // timeSlots.sort();
    // weekdays = timeSlotsModels.map((model) => model.weekdays).toList();
    print(weekdays);
    // Do something with the timeSlotsModels if needed
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    final currentDate = DateTime.now();
    DateTime selectedDate = DateTime.now();
    final daysInMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    final List<DateTime> daysList =
        List<DateTime>.generate(daysInMonth, (index) {
      return DateTime(currentDate.year, currentDate.month, index + 1);
    });

    return Scaffold(
      body: Stack(children: [
        // ListView.builder(
        //   itemCount: widget.singleProduct.images.length,
        //   itemBuilder: (context, index) {
        //     return Positioned(
        //       left: 0,
        //       right: 0,
        //       child: Container(
        //         width: double.maxFinite,
        //         height: Dimensions.popularClassImageSize,
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             fit: BoxFit.cover,
        //             image: NetworkImage(widget.singleProduct.images[index]),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /*Image.network(widget.singleProduct.image,
                  height: 400, width: 400, fit: BoxFit.cover),*/
          Container(
            height: 400, // Set a fixed height for the viewer

            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.singleProduct.images.length,
              physics: PageScrollPhysics(), // Use PageScrollPhysics

              itemBuilder: (BuildContext context, int index) {
                String imageUrl = widget.singleProduct.images[index];
                return Container(
                  child: ClipRRect(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
        Positioned(
          top: Dimensions.height45,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40 / 2),
                    // color: Color(0xFFfcf4e4)),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    // color: Color(0xFF756d54),
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: Dimensions.popularClassImageSize - 20,
          child: Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20),
                topLeft: Radius.circular(Dimensions.radius20),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                          text: widget.singleProduct.name,
                          size: Dimensions.font26),
                      SizedBox(height: Dimensions.height10),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: Dimensions.height15,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width10),
                          SmallText(text: "5"),
                          SizedBox(width: Dimensions.width10),
                          SmallText(text: "리뷰: "),
                          SizedBox(width: Dimensions.width3),
                          SmallText(text: "1287"),
                        ],
                      ),
                      SizedBox(height: Dimensions.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconAndTextWidget(
                            icon: Icons.category,
                            text: widget.singleProduct.exerciseType,
                            iconColor: AppColors.iconColor1,
                          ),
                          IconAndTextWidget(
                            icon: Icons.location_on,
                            text: widget.singleProduct.distance,
                            iconColor: AppColors.mainColor,
                          ),
                          IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: widget.singleProduct.duration,
                            iconColor: AppColors.iconColor2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "수업 정보"),
                  SizedBox(height: Dimensions.height20),
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     child: ExpandableTextWidget(
                  //         text: widget.singleProduct.description),
                  //   ),
                  // ),
                  Text(
                    widget.singleProduct.description,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      color: AppColors.paraColor,
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "가격 정보"),
                  SizedBox(height: Dimensions.height20),

                  // Center(
                  //   child: SmallText(
                  //       text: (((widget.singleProduct.originalPrice -
                  //                           widget.singleProduct
                  //                               .creditsRequired) /
                  //                       widget.singleProduct.originalPrice) *
                  //                   100)
                  //               .toInt()
                  //               .toString() +
                  //           "% 할인",
                  //       color: Colors.black,
                  //       size: 18),
                  // ),
                  // SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          Colors.white, // Specify the desired background color
                      border: Border.all(
                        color: Color.fromARGB(255, 225, 225, 225),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: formatter.format(
                                  widget.singleProduct.creditsRequired) +
                              "원\n ",
                          style: DefaultTextStyle.of(context)
                              .style
                              .copyWith(fontSize: 24),
                          children: <TextSpan>[
                            TextSpan(
                              text: formatter.format(
                                      widget.singleProduct.originalPrice) +
                                  "원",
                              style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 2.0,
                                fontSize: 20,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.all(10),
                  //       child: Column(children: [
                  //         SmallText(
                  //             text: "기존 가격",
                  //             color: AppColors.paraColor,
                  //             size: 18),
                  //         SmallText(
                  //             text: widget.singleProduct.originalPrice
                  //                     .toString() +
                  //                 "원",
                  //             color: AppColors.paraColor,
                  //             size: 18),
                  //       ]),
                  //     ),
                  //     SizedBox(
                  //       width: 50,
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Colors.black,
                  //           width: 2.0, // Set the border width
                  //         ),
                  //       ),
                  //       padding: EdgeInsets.all(10),
                  //       child: Column(
                  //         children: [
                  //           SmallText(
                  //               text: "GoFit 가격",
                  //               color: Colors.black,
                  //               size: 18),
                  //           SmallText(
                  //               text: widget.singleProduct.creditsRequired
                  //                       .toString() +
                  //                   "원",
                  //               color: Colors.black,
                  //               size: 18),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 15,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 20),

                  BigText(text: "수업 정보"),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                //height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        widget.singleProduct!.requirements,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Pretendard',
                                            color: AppColors.paraColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                //height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.singleProduct!.hasShower
                                          ? '샤워 가능'
                                          : '샤워 불가능',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          color: AppColors.paraColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  BigText(text: "공지사항"),
                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.singleProduct.info
                        .map((text) => Column(
                              children: [
                                Text(
                                  text,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Pretendard',
                                      color: AppColors.paraColor),
                                ),
                                SizedBox(height: 20),
                              ],
                            ))
                        .toList(),
                  ),
                  BigText(text: "운영시간"),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.singleProduct.businessHours
                        .map((text) => Column(
                              children: [
                                Text(
                                  text,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Pretendard',
                                      color: AppColors.paraColor),
                                ),
                                SizedBox(height: 20),
                              ],
                            ))
                        .toList(),
                  ),

                  BigText(text: "수업예약"),
                  SizedBox(height: 20),

                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 225, 225, 225),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: daysList.asMap().entries.map((entry) {
                          final index = entry.key;
                          final day = entry.value;
                          final weekdayName = DateFormat.E('ko_KR').format(day);
                          final weekdayNumber =
                              day.weekday; // Get the weekday as an integer

                          final isCurrentDay = day.day == currentDate.day;
                          final isSelected = selectedIndex == index;
                          final isBeforeToday = day.isBefore(currentDate);
                          final isClickable = !isBeforeToday || isCurrentDay;

                          // Check if the day is before the current date and not the current day
                          if (isBeforeToday && !isCurrentDay) {
                            return Container();
                            // Return an empty container to hide the day
                          }
                          if (!(entry.value.day <= (currentDate.day + 7))) {
                            return Container();
                          }

                          return GestureDetector(
                            onTap: isClickable
                                ? () {
                                    setState(() {
                                      selectedIndex = index;
                                      matchingTimeSlots = timeSlotsModels
                                          .where((model) => model.weekdays
                                              .contains(weekdayNumber))
                                          .toList();
                                      matchingTimeSlots.sort(
                                        (a, b) =>
                                            a.startTime.compareTo(b.startTime),
                                      );
                                      selectedTimeSlot = null;
                                    });
                                  }
                                : null,
                            child: Container(
                              width: 60,
                              height: 80,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color.fromARGB(150, 193, 227, 255)
                                    : Colors.white,
                                border: isSelected ||
                                        (isCurrentDay && isClickable)
                                    ? Border.all(color: Colors.blue, width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${day.day}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    weekdayName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 225, 225, 225),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: matchingTimeSlots.map((timeSlots) {
                          final isSelected = selectedTimeSlot == timeSlots;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTimeSlot = timeSlots;
                              });
                            },
                            child: Container(
                              // padding: EdgeInsets.all(10),
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color.fromARGB(150, 193, 227, 255)
                                    : Colors.white,
                                border: isSelected
                                    ? Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                timeSlots.startTime,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 38,
                        width: 140,
                        child: PrimaryButton(
                          title: "예약하기",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  BigText(text: "리뷰:"),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ]),
    );

    /*Scaffold(
      appBar: AppBar(
        actions: [
          /*IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const CartScreen(), context: context);
            },
            icon: const Icon(Icons.shopping_cart),
          )*/
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Image.network(widget.singleProduct.image,
                  height: 400, width: 400, fit: BoxFit.cover),*/
                    Container(
                      height: 400, // Set a fixed height for the viewer

                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.singleProduct.images.length,
                        physics: PageScrollPhysics(), // Use PageScrollPhysics

                        itemBuilder: (BuildContext context, int index) {
                          String imageUrl = widget.singleProduct.images[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical:
                                    12.0), // Add some spacing between images
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.singleProduct.name,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.singleProduct.isFavourite =
                                  !widget.singleProduct.isFavourite;
                            });
                            if (widget.singleProduct.isFavourite) {
                              appProvider
                                  .addFavouriteProduct(widget.singleProduct);
                            } else {
                              appProvider
                                  .removeFavouriteProduct(widget.singleProduct);
                            }
                          },
                          icon: Icon(appProvider.getFavouriteProductList
                                  .contains(widget.singleProduct)
                              ? Icons.favorite
                              : Icons.favorite_border),
                        ),
                      ],
                    ),
                    SmallText(
                      text: widget.singleProduct.description,
                      size: 18,
                      maxLines: 10,
                      color: Colors.black,
                    ),
                    Divider(
                      thickness: 1,
                      height: 40,
                      color: Colors.grey,
                      indent: 0,
                      endIndent: 0,
                    ),
                    BigText(text: "가격정보"),
                    SizedBox(height: 10),
                    Center(
                      child: SmallText(
                          text: (((widget.singleProduct.originalPrice -
                                              widget.singleProduct
                                                  .creditsRequired) /
                                          widget.singleProduct.originalPrice) *
                                      100)
                                  .toInt()
                                  .toString() +
                              "% 할인",
                          color: Colors.black,
                          size: 18),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(children: [
                            SmallText(
                                text: "기존 가격", color: Colors.black, size: 18),
                            SmallText(
                                text: widget.singleProduct.originalPrice
                                        .toString() +
                                    "원",
                                color: Colors.black,
                                size: 18),
                          ]),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Set the border color
                              width: 2.0, // Set the border width
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SmallText(
                                  text: "GoFit 가격",
                                  color: Colors.black,
                                  size: 18),
                              SmallText(
                                  text: widget.singleProduct.creditsRequired
                                          .toString() +
                                      "원",
                                  color: Colors.black,
                                  size: 18),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),

                    //Text(widget.singleProduct.description),
                    const SizedBox(
                      height: 12.00,
                    ),
                    Divider(
                      thickness: 1,
                      height: 40,
                      color: Colors.grey,
                      indent: 0,
                      endIndent: 0,
                    ),
                    BigText(text: "수업 정보 요약"),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    //color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        // child: FaIcon(
                                        //   FontAwesomeIcons.tshirt,
                                        //   color: Colors.black,
                                        //   size: 30,
                                        // ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3, 0, 3, 0),
                                        child: Text(
                                          style: TextStyle(fontSize: 20),
                                          widget.singleProduct!.requirements,
                                          textAlign: TextAlign.center,
                                          //style: FlutterFlowTheme.of(context).bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    //color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                        // child: FaIcon(
                                        //   FontAwesomeIcons.stopwatch,
                                        //   color: Colors.black,
                                        //   size: 30,
                                        // ),
                                      ),
                                      Text(
                                        style: TextStyle(fontSize: 20),

                                        widget.singleProduct!.duration,
                                        //style: FlutterFlowTheme.of(context).bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 100,
                                decoration: BoxDecoration(
                                  //color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 5),
                                      // child: FaIcon(
                                      //   FontAwesomeIcons.shower,
                                      //   color: Colors.black,
                                      //   size: 30,
                                      // ),
                                    ),
                                    Text(
                                      style: TextStyle(fontSize: 20),
                                      widget.singleProduct!.hasShower
                                          ? '샤워 가능'
                                          : '샤워 불가능',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 24.0,
                    ),
                    BigText(text: "수업예약"),

                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 225, 225, 225),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: daysList.asMap().entries.map((entry) {
                            final index = entry.key;
                            final day = entry.value;
                            final weekdayName = DateFormat('EEE').format(day);
                            final weekdayNumber =
                                day.weekday; // Get the weekday as an integer

                            final isCurrentDay = day.day == currentDate.day;
                            final isSelected = selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  matchingTimeSlots = timeSlotsModels
                                      .where((model) => model.weekdays
                                          .contains(weekdayNumber))
                                      .toList();
                                  matchingTimeSlots.sort((a, b) =>
                                      a.startTime.compareTo(b.startTime));
                                });
                              },
                              child: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Color.fromARGB(150, 193, 227, 255)
                                      : Colors.white,
                                  border: isSelected
                                      ? Border.all(color: Colors.blue, width: 2)
                                      : isCurrentDay
                                          ? Border.all(
                                              color: Colors.blue, width: 2)
                                          : null,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      weekdayName,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 225, 225, 225),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: matchingTimeSlots.map((timeSlots) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              height: 50,
                              child: Center(
                                child: Text(
                                  timeSlots.startTime,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // OutlinedButton(
                        //   onPressed: () {
                        //     // ProductModel productModel =
                        //     //     widget.singleProduct.copyWith(qty: qty);
                        //     //appProvider.addCartProduct(productModel);
                        //     showMessage("Added to Cart");
                        //   },
                        //   child: const Text("ADD TO CART"),
                        // ),
                        SizedBox(
                          height: 38,
                          width: 140,
                          child: /*ElevatedButton(
                      onPressed: () {
                        // ProductModel productModel =
                        //     widget.singleProduct.copyWith(qty: qty);
                        // Routes.instance.push(
                        //     widget: Checkout(singleProduct: productModel),
                        //     context: context);
                      },
                      child: const Text("예약하기"),
                    ),*/
                              PrimaryButton(
                            title: "예약하기",
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ),
    );*/
  }
}
