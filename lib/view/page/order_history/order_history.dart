import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outlet/view/page/order_history/controller/order_history_controller.dart';

import '../../../constant/constant.dart';
import '../../../model/hive_purchase.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderHistoryController controller = Get.find();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Purchase History",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<HivePurchase>(purchaseBox).listenable(),
        builder: (context, Box<HivePurchase> box, widget) {
          debugPrint("*************${box.values.length}*****");
          return box.isNotEmpty
              ? SizedBox(
                  height: size.height,
                  width: size.width,
                  child: ListView(
                    children: box.values.map((purchase) {
                      return Obx(() {
                        return Dismissible(
                          key: Key(purchase.id),
                          background: Container(
                            color: Colors.black12,
                          ),
                          onDismissed: (direction) {
                            box.delete(purchase.id);
                          },
                          direction: DismissDirection.startToEnd,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpansionPanelList(
                                expansionCallback: (index, isExpanded) =>
                                    controller.setPurchaseId(purchase.id),
                                children: [
                                  ExpansionPanel(
                                    isExpanded: controller.purchaseId.value ==
                                        purchase.id,
                                    canTapOnHeader: true,
                                    headerBuilder: (context, isExpand) {
                                      return ListTile(
                                        title: Text(
                                            "ကုန်ပစ္စည်းအရေအတွက် = ${purchase.items.length}ခု"),
                                        subtitle: Text(
                                            "${purchase.totalPrice} ကျပ် "
                                            "ပို့ခ ${purchase.deliveryTownshipInfo[1]}ကျပ် ပေါင်းပြီး"),
                                        trailing: Text(
                                            "${purchase.dateTime.day}/${purchase.dateTime.month}/${purchase.dateTime.year}"),
                                      );
                                    },
                                    body: SizedBox(
                                      height: purchase.items.length * 50,
                                      width: size.width * 0.8,
                                      child: ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        itemCount: purchase.items.length,
                                        itemBuilder: (_, o) {
                                          final item = purchase.items[o];
                                          final price = item.dicountPrice > 0
                                              ? item.dicountPrice
                                              : item.requirePoints > 0
                                                  ? item.requirePoints
                                                  : item.price;
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  item.features,
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                Text(
                                                  item.features,
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                ),
                                                Text(
                                                  "$price x  ${item.count} ခု",
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                )
              : const Center(
                  child: Text("No order history."),
                );
        },
      ),
    );
  }
}
