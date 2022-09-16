import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:outlet/view/page/search/search_controller.dart';

import '../../../constant/constant.dart';
import '../../../controller/home_controller.dart';
import '../../../utils/routes/route_url.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    Get.put(SearchController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchController controller = Get.find();
    final HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: appBarColor,
        elevation: 0,
        title: TextField(
          autofocus: true,
          onChanged: (value) => controller.onSearch(value),
          decoration: const InputDecoration(
            hintText: "Search...",
            // border: OutlineInputBorder(),
          ),
        ),
      ),
      body: Obx(() {
        return controller.searchItems.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: controller.searchItems.length,
                itemBuilder: (_, i) => Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeController.setSelectedItem =
                            controller.searchItems[i];
                        Get.toNamed(productDetailScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: controller.searchItems[i].image.first,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          controller.searchItems[i].image.first,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 24, right: 20),
                                      child: Text(
                                        controller.searchItems[i].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 30,
                                          right: 20),
                                      child: Text(
                                        "${controller.searchItems[i].price} Kyats",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  "Let's search what you want!",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
      }),
    );
  }
}
