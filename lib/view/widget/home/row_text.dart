
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RowText extends StatelessWidget {
  const RowText({
    Key? key,
    required this.left,
    required this.right,
  }) : super(key: key);

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Wrap(
              children: [
                Text(
                  left,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(
                  width: 15,
                ),
                 Text(
                    right,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
      ),
    );
  }
}
