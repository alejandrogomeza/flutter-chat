import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType textKeyboardType;
  final bool isPassword;

  const CustomInput({super.key, 
    required this.icon, 
    required this.placeholder,
    required this.textController, 
    this.textKeyboardType = TextInputType.text, 
    this.isPassword = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
      padding: const EdgeInsets.only(left: 5, right: 20, top: 0, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5
          )
        ]
      ),

      child: TextField(
        controller: textController,
        autocorrect: false,
        obscureText: isPassword,
        keyboardType: textKeyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: placeholder,
        ),
      ),
    );
  }
}