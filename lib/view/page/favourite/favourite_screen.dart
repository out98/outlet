import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlet/model/hive_product.dart';
import 'package:outlet/utils/routes/route_url.dart';

import '../../../constant/constant.dart';
import '../../../controller/home_controller.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "favourites products",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<HiveProduct>(boxName).listenable(),
        builder: (context, Box<HiveProduct> box, widget) {
          return box.isNotEmpty
              ? ListView(
                  children: box.values
                      .map(
                        (hiveItem) {
                          return Dismissible(
                            key: Key(hiveItem.name),
                            background: Container(
                              color: Colors.black12,
                            ),
                            onDismissed: (direction) {
                              box.delete(hiveItem.id);
                            },
                            direction: DismissDirection.startToEnd,
                            child: Card(
                              child: ListTile(
                                onTap: () {
                                  //TODO: GO TO DETAIL AND CHANGE OBJECT
                                  controller.setSelectedItem = controller
                                      .products
                                      .where((e) => e.id == hiveItem.id)
                                      .first;
                                  Get.toNamed(productDetailScreen);
                                },
                                title: Text(
                                  hiveItem.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text("${hiveItem.price} kyats"),
                                trailing: AspectRatio(
                                  aspectRatio: 1,
                                  child: Hero(
                                    tag: hiveItem.image,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CachedNetworkImage(
                                        imageUrl: hiveItem.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      .toList()
                      .reversed
                      .toList(),
                )
              : const Center(child: Text("No Favourite List"));
        },
      ),
    );
  }
}
