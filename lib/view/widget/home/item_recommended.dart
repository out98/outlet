import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outlet/model/product.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/mock.dart';


class ItemRecommended extends StatefulWidget {
  final String title;
  final List<Product> products;
  const ItemRecommended({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  @override
  State<ItemRecommended> createState() => _ItemRecommendedState();
}

class _ItemRecommendedState extends State<ItemRecommended> {
  final ScrollController _scrollController = ScrollController();

  void changePosition(double value) => _scrollController
  .animateTo(value, duration: const Duration(milliseconds: 500), 
  curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/12,
      child: LayoutBuilder(
        builder: (context,constrains) {
          final height = constrains.maxHeight;
          final width = constrains.maxWidth;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Text(widget.title,style: Theme.of(context).textTheme.bodyText2),
              ),
              //Divider
              const Padding(
                padding:  EdgeInsets.only(left: 15,right: 15),
                child:  Divider(color: Colors.pink,thickness: 8,),
              ),
              //Horizontal ProductList
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: widget.products.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          final product = widget.products[index];
                          return SizedBox(
                            width: width/2,
                            child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(8),
                                          child: CachedNetworkImage(
                                                  progressIndicatorBuilder: (context, url, status) {
                                                    return Shimmer.fromColors(
                                                      child: Container(
                                                        color: Colors.white,
                                                      ),
                                                      baseColor: Colors.grey.shade300,
                                                      highlightColor: Colors.white,
                                                    );
                                                  },
                                                  errorWidget: (context, url, whatever) {
                                                    return const Text("Image not available");
                                                  },
                                                  imageUrl: product.image.first,
                                                  fit: BoxFit.contain,
                                                ),
                                          )),
                                    const SizedBox(height: 15),
                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        product.description,
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme
                                            .subtitle1,
                                          ),
                                        ],
                                      ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //LeftButton
                          IconButton(
                            onPressed: (){
                              if(_scrollController.offset == _scrollController
                              .initialScrollOffset){
                                changePosition((foodRecommand.length - 2) * (width/2));
                              }else{
                                changePosition(_scrollController.offset - (2 * (width/2)));
                              }
                            },
                            icon:  const Icon(
                              FontAwesomeIcons.circleChevronLeft,
                              color: Colors.pinkAccent,
                              size: 30,
                              ),
                          ),
                          //RightButton
                          IconButton(
                            onPressed: (){
                              if(_scrollController.offset == _scrollController
                              .position.maxScrollExtent){
                                changePosition(0.0);
                              }else{
                                changePosition(_scrollController.offset + (2 * (width/2)));
                              }
                            },
                            icon: const Icon(
                              FontAwesomeIcons.circleChevronRight,
                              color: Colors.pinkAccent,
                              size: 30,
                              ),
                          )
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
