import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({super.key, 
    required this.texto, 
    required this.uid, 
    required this.animationController
  });


  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == '123'
          ? _myMessage()
          : _notMyMessage()
        ),
      ),
    );
  }
  
  Widget _myMessage() {

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(left: 50, right: 10, top: 0, bottom: 5),
        decoration: BoxDecoration(
          color: const  Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(texto, style: const TextStyle(color: Colors.white),),
      ),
    );
    
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(left: 10, right: 50, top: 0, bottom: 5),
        decoration: BoxDecoration(
          color: const  Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(texto, style: const TextStyle(color: Colors.black),),
      ),
    );
  }
}