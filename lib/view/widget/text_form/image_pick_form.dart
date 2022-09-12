import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImagePickForm extends StatelessWidget {
  const ImagePickForm({
    Key? key,
    this.height,
    required this.labelText,
    this.textFieldPaddingLeft,
    required this.pickImage,
  }) : super(key: key);

  final double? height;
  final String labelText;
  final double? textFieldPaddingLeft;
  final void Function() pickImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                counter: null,
                counterText: "",
                hintText: labelText,
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                contentPadding: EdgeInsets.only(left: 10),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
          ),
          IconButton(
            onPressed: pickImage,
            icon: const Icon(FontAwesomeIcons.image),
          )
        ],
      ),
    );
  }
}
