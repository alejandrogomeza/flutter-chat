import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat/services/services.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:chat/models/models.dart';

class ChatPage extends StatefulWidget {
   
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;


  final List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioID) async {
    List<Mensaje> chat = await chatService.getChat(usuarioID);
    
    final history = chat.map((msg) => ChatMessage(texto: msg.mensaje, 
      uid: msg.de, 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 0 ))..forward()
    ));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _escucharMensaje(dynamic payload) {

    print(payload['mensaje']);
    ChatMessage message = ChatMessage(texto: payload['mensaje'], 
      uid: payload['de'], 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 300)),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 12,
              child: Text(usuarioPara.nombre.substring(0,2), style: const TextStyle(fontSize: 12),),
            ),
            const SizedBox(height: 3,),
            Text(usuarioPara.nombre, style: const TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i],
                itemCount: _messages.length,
                reverse: true,        
              ),
            ),

            const Divider(height: 1.0),

            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (texto){

                  setState(() {
                    if(texto.trim().isNotEmpty) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });

                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
              ),
            ),

            // Botón de enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
              child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _estaEscribiendo
                      ? () => _handleSubmit(_textController.text.trim())
                      : null,
                    child: const Text('Enviar')
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.blue,),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: const Icon(Icons.send), 
                        onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_textController.text.trim())
                          : null
                      ),
                    ),
                  )
                  
            )

          ],
        ),
      ),

    );

  }


  _handleSubmit(String texto) {

    if(texto.isEmpty) return;
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto, 
      uid: authService.usuario!.uid, 
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 300)),
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });

    socketService.emit('mensaje-personal', {
      'de': authService.usuario!.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': texto,

    });
  }

  @override
  void dispose() {
    for(ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }

}