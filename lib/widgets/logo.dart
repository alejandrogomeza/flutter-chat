import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String titulo;

  const Logo({super.key, required this.titulo});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 0, right: 0, top: 50, bottom: 0),
        width: 150,
        child: Column(
          children: [
            const Image(image: AssetImage('assets/tag-logo.png')),
            const SizedBox(height: 20),
            Text(titulo, style: TextStyle(fontSize: 25))
            
          ],
        ),
      ),
    );
  }
}