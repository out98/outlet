
import 'package:flutter/material.dart';

import '../../../constant/mock.dart';

class MainCategoryGrid extends StatelessWidget {
  const MainCategoryGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
        ), 
      itemBuilder: (context,index){
        final mainCategory = mainCategories[index];
        final isRight = (index + 1)%4 == 0;
        final isLeft = (index + 1)%4 == 1;
        final middleLeft = (index + 1)%4 == 2;
        final last4 = mainCategories.length - 4;
        final last4Container = index == last4 || index > last4;
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: isRight || isLeft ? 
             Border(
              top: const BorderSide(color: Colors.grey),
              bottom: BorderSide(color:
              last4Container ? Colors.grey : Colors.transparent),
            ) : (middleLeft ? Border(
              top: const BorderSide(color: Colors.grey),
              bottom: BorderSide(
                color: last4Container ? 
                Colors.grey : Colors.transparent),
              left: const BorderSide(color: Colors.grey),
            ): Border( 
              top: const BorderSide(color: Colors.grey),
              left: const BorderSide(color: Colors.grey),
              right: const BorderSide(color: Colors.grey),
              bottom: BorderSide(color:
              last4Container ? Colors.grey : Colors.transparent),))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(mainCategory.image),
              Text(
              mainCategory.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme
              .subtitle1,),
            ],
          )
        );
      },
      itemCount: mainCategories.length,
    );
  }
}