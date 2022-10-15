import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final String titulo;
  final String subtitulo;


  const Labels({super.key, required this.ruta, required this.titulo, required this.subtitulo});


  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: [
          Text(titulo, style: const TextStyle(color: Colors.black38, fontSize: 13)),
          const SizedBox(height: 10.0),
          GestureDetector(
            child: Text(subtitulo, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16)),
            onTap: (){
              Navigator.pushReplacementNamed(context, ruta);
            },
          ),
          const SizedBox(height: 10.0),

        ],
      ),
    );
  }
}