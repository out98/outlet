import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constant/mock.dart';
import 'row_text.dart';


class NewProducts extends StatelessWidget {
  const NewProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade100,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const RowText(left: "NEW ITEMNew",right: "/ product"),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              childAspectRatio: 0.6,
              ), 
            itemBuilder: (context,index){
              final product = newProducts[index];
              final month = product.dateTime.month;
              final day = product.dateTime.day;
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
                //Status and Released Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 55,
                      child: ElevatedButton(
                        onPressed: (){}, 
                        child: Text(product.status ?? "",
                        style:const TextStyle(color: Colors.white,
                        fontSize: 10),),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Released on $month/$day",
                      style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 5),
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
            itemCount: newProducts.length,
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
      )
    );
  }
}


