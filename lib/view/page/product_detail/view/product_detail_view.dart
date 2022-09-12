import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlet/model/hive_product.dart';
import 'package:outlet/model/product.dart';
import 'package:outlet/model/review.dart';
import 'package:outlet/view/page/product_detail/controller/product_detail_controller.dart';
import 'package:outlet/view/widget/rating_bar/immutable_ratingbar.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constant/constant.dart';
import '../../../../constant/mock.dart';
import '../../../../controller/home_controller.dart';
import '../../../widget/prouct_detail/expanded_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final currentProduct = controller.selectedItem.value!;
    final category = controller.firstCategories
        .where((e) => e.id == currentProduct.parentId)
        .first
        .name;
    final brand = controller.brands
        .where((e) => e.id == currentProduct.brandId)
        .first
        .name;
    final size = MediaQuery.of(context).size;
    final ProuctDetailController detailController = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          category,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Form(
        key: detailController.formKey,
        child: ListView(
          children: [
            Container(
              // ignore: sort_child_properties_last
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Hero(
                  tag: currentProduct.image.first,
                  child: CarouselSlider(
                    items: [
                      CachedNetworkImage(
                        imageUrl: currentProduct.image.first,
                        // "$baseUrl$itemUrl${currentProduct.photo}/get",
                        height: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                      CachedNetworkImage(
                        imageUrl: currentProduct.image.first,
                        // "$baseUrl$itemUrl${currentProduct.photo}/get",
                        height: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                      CachedNetworkImage(
                        imageUrl: currentProduct.image.first,
                        // "$baseUrl$itemUrl${currentProduct.photo}/get",
                        height: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    currentProduct.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Favourite Icon
                        ValueListenableBuilder(
                          valueListenable:
                              Hive.box<HiveProduct>(boxName).listenable(),
                          builder: (context, Box<HiveProduct> box, widget) {
                            final currentObj = box.get(currentProduct.id);

                            if (!(currentObj == null)) {
                              return IconButton(
                                  onPressed: () {
                                    box.delete(currentObj.id);
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Colors.red,
                                    size: 25,
                                  ));
                            }
                            return IconButton(
                                onPressed: () {
                                  box.put(
                                      currentProduct.id,
                                      HiveProduct(
                                        id: currentProduct.id,
                                        name: currentProduct.name,
                                        image: currentProduct.image.first,
                                        description: currentProduct.description,
                                        features: currentProduct.features ?? "",
                                        price: currentProduct.price,
                                      ));
                                },
                                icon: const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.red,
                                  size: 25,
                                ));
                          },
                        ),
                      ]),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "အမှတ်တံဆိပ် (Brand)",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        brand,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "တစ်စည်ဈေး (WholeSale)",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "${currentProduct.price} Kyats",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Discount",
                  //       style: TextStyle(
                  //           color: Colors.red,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16),
                  //     ),
                  //     Text(
                  //       "${currentProduct.price} Kyats",
                  //       style: TextStyle(
                  //           decoration: TextDecoration.lineThrough,
                  //           color: Colors.red,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16),
                  //     ),
                  //     Text(
                  //       (currentProduct.discountPrice ?? 0) > 0 ?
                  //       "${currentProduct.discountPrice} Kyats" : "no discount price",
                  //       style: TextStyle(
                  //           color: Colors.red,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  ExpandedWidget(
                    text: currentProduct.description,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "⏰ Delivery Time",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              currentProduct.dateTime.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(
                              "💁 Availability ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "In Stock",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "📞 Contact Phone ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "     09 265 700 006",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: currentProduct.image.first,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: currentProduct.image.first,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        " 🏠 ဆိုင်လိပ်စာ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'အမှတ် ၂၁၇ - ၂၃၆ ၊ ၂၉လမ်း အထက် ၊ ပန်းဘဲတန်းမြို့နယ်၊ ရန်ကုန်မြို့။',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "☎ ဆက်သွယ်နိုင်တဲ့ ဖုန်းနံပါတ်",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '''   09 265 700 006
                          09 796 700 006
                                              
                          09 952 700 006''',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  //Give Rating and write product review
                  const Text("Give rating"),
                  const SizedBox(height: 5),
                  //Rating Bar
                  Obx(() {
                    final rating = detailController.rating.value;
                    final isError = detailController.rateError.value &&
                        detailController.firstTimePressed.value;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isError ? Colors.red : Colors.transparent),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              detailController.changeRating(rating);
                            },
                          ),
                          const SizedBox(width: 15),
                          //TextField
                          Expanded(
                              child: TextField(
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                detailController.changeRating(
                                  value.length > 1
                                      ? double.parse(value)
                                      : int.parse(value) + 0.0,
                                );
                              }
                            },
                            controller: detailController.ratingController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "0.0",
                            ),
                          )),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 1),
                  //Review List
                  Obx(() {
                    final reviewsList = detailController.reviewsList;
                    if (reviewsList.isNotEmpty) {
                      final header = reviewsList.first;
                      final expande = reviewsList.length > 1
                          ? reviewsList.sublist(1, reviewsList.length)
                          : [];
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ExpandablePanel(
                          header: UserReviewWidget(review: header, size: size),
                          collapsed: const SizedBox(),
                          expanded: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: expande.length,
                            itemBuilder: (context, index) {
                              return UserReviewWidget(
                                  review: expande[index], size: size);
                            },
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                  const SizedBox(height: 15),
                  //Write review form
                  Obx(() {
                    final isError = detailController.reviewError.value &&
                        detailController.firstTimePressed.value;
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isError ? Colors.red : Colors.grey),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: detailController.reviewController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: "Write review..",
                              border: InputBorder.none,
                            ),
                          ),
                          //Submit
                          ElevatedButton(
                            onPressed: () => detailController.writeReiew(
                              currentProduct.id,
                            ),
                            child: Obx(() {
                              return detailController.isLoading.value
                                  ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text("Submit");
                            }),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 65,
        // decoration: BoxDecoration(
        //   color: detailBackgroundColor,
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(20),
        //     topRight: Radius.circular(20),
        //   ),
        // ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: ElevatedButton(
          onPressed: () {},
          child: Text("၀ယ်ယူရန်"),
        ),
      ),
    );
  }
}

class UserReviewWidget extends StatelessWidget {
  const UserReviewWidget({
    Key? key,
    required this.review,
    required this.size,
  }) : super(key: key);

  final Review review;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Top
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Profile
                CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, status) {
                    return Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.yellow,
                      child: Container(
                        color: Colors.white,
                      ),
                    );
                  },
                  errorWidget: (context, url, whatever) {
                    return const Text("Image not available");
                  },
                  imageUrl: review.user.image,
                  imageBuilder: (context, provider) {
                    return CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade300,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: provider,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                ),
                Text(
                  review.user.userName,
                ),
              ],
            ),
            //Rating Bar
            ImmutableRatingBar(
              rating: review.rating,
            ),
          ],
        ),
        //Message
        SizedBox(
          width: size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              review.reviewMessage,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        //Date
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${review.dateTime.year}-${review.dateTime.month}-${review.dateTime.day}",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}/* 
class AddToCart extends StatefulWidget {
  final String imageUrl;
  final List<own.Size> sizePriceList;
  final String color;
  const AddToCart({
    Key? key,
    required this.imageUrl,
    required this.sizePriceList,
    required this.color,
  }) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
} */
/* 
class _AddToCartState extends State<AddToCart> {
  String? colorValue;
  String? discountPercentage;
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          //Default Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  width: 100,
                  height: 100,
                  progressIndicatorBuilder:
                      (context, url, status) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: status.progress,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),),
              Text(
                sizePrice?.size ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              //
              SizedBox(
                height: widget.sizePriceList.length * 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var element in widget.sizePriceList) ...[
                      Text(
                        "${element.price}",
                        textAlign: sizePrice == element
                            ? TextAlign.right
                            : TextAlign.center,
                        style: TextStyle(
                          decoration: sizePrice == element
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                          fontSize: sizePrice == element ? 20 : 12,
                          color: sizePrice == element
                              ? homeIndicatorColor
                              : Colors.black,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //SizePrice
          SizedBox(
            height: 80,
            child: Wrap(
              children: widget.sizePriceList.map((element) {
                return Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: sizePrice?.id == element.id
                            ? homeIndicatorColor
                            : Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      //TODO: CHANGE SIZEPRICE
                      setState(() {
                        sizePrice = element;
                      });
                    },
                    child: Text(
                      element.size,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          //
          SizedBox(
            width: 120,
            child: DropdownButtonFormField(
              value: colorValue,
              hint: Text(
                'Color',
                style: TextStyle(fontSize: 12),
              ),
              onChanged: (String? e) {
                colorValue = e;
              },
              items: widget.color
                  .split(',')
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(fontSize: 12),
                ),
              ))
                  .toList(),
            ),
          ),

          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              if (colorValue != null && !(sizePrice == null)) {
                controller.addToCart(controller.editItem.value!,color: colorValue!,
                    size: [sizePrice!.size,sizePrice!.price],price: int.parse(sizePrice!.price));
                Get.toNamed(homeScreen);
              }
            },
            child: Text("၀ယ်ယူရန်"),
          ),
        ],
      ),
    );
  } 
}*/