import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constant/mock.dart';
import 'row_text.dart';


class FeatureListProductInformation extends StatelessWidget {
  const FeatureListProductInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
    const SizedBox(height: 10),
    const RowText(left: "PRODUCT",right: "/ Feature List/Product Information"),
    GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        childAspectRatio: 0.6,
        ), 
      itemBuilder: (context,index){
        final product = featureListItems[index];
        return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: Image.network(product.image.first)
            )),
            const SizedBox(height: 15),
        Text(
          product.name,
          maxLines: 2,
          style: Theme.of(context).textTheme
              .subtitle1,
            ),
          ],
        )
        );
      },
      itemCount: featureListItems.length,
    ),
    const SizedBox(height: 20),
    //See All
    SizedBox(
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const RoundedRectangleBorder(),
        ),
        onPressed: (){}, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Icon(FontAwesomeIcons.chevronRight,color: Colors.pink,),
            const SizedBox(width: 10),
            Text("See the list",style: Theme.of(context)
            .textTheme.subtitle1)
          ],
        ),
        ),
    ),
    const SizedBox(height: 30),
        ],
      );
  }
}
