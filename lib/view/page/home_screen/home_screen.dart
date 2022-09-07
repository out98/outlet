import 'package:flutter/material.dart' hide Slider;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outlet/constant/constant.dart';
import 'package:outlet/constant/mock.dart';
import 'package:outlet/view/widget/home/advertisements_slider.dart';

import '../../widget/home/brand_grid.dart';
import '../../widget/home/hot_topics_slider.dart';
import '../../widget/home/main_category_grid.dart';
import '../../widget/home/row_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        title: Image.network(logo,height: 80),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(FontAwesomeIcons.searchengin)
          ),
        ],
      ),
      drawer: Container(color: Colors.white),
      body: ListView(
        children:  [
          const AdvertisementsSlider(),
          const MainCategoryGrid(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Topvalu incorporates customer feedback into its products",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const Divider(color: Colors.black54,height: 1,),
          const SizedBox(height: 10),
          const RowText(left: "BRANDBrand",right: "/ information"),
          const SizedBox(height: 10),
          const BrandGrid(),
          const SizedBox(height: 10),
          const RowText(left: "HOT TOPICSrecommended",right: "/ information"),
          const SizedBox(height: 10),
          const HotTopicsSlider(),
         Center(
           child: SizedBox(
            width: size.width*0.8,
             child: ElevatedButton(
                  onPressed: (){}, 
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.cartShopping,size: 35),
                        const SizedBox(width: 10),
                        Text(
                          "Click here to shop!",
                          style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
           ),
         ),
        ],
      ),
    );
  }
}

