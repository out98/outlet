import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ClipHereToShop extends StatelessWidget {
  const ClipHereToShop({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}