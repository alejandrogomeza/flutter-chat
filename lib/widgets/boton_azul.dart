import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final void Function()? onPressed;

  const BotonAzul({super.key, 
    required this.text, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,

      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

  