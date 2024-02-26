import 'package:chat/constans/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
 const  CustomTextFormField({super.key, required this.hintText, required this.keyboard, this.onChanged, this.pass, this.validator});
final String hintText;
final bool? pass;
final TextInputType keyboard;
final Function(String)? onChanged;
final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        keyboardType: keyboard,
        onChanged: onChanged,
        obscureText: pass ?? false ,
        decoration: InputDecoration(
          hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xffA4A4A4),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: kActiveColor,
                width: 3,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )
        ),
      ),
    );
  }
}
