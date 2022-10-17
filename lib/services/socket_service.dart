
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:chat/services/services.dart';
import 'package:chat/global/environment.dart';

enum ServerStatus{
  Online,
  Offline,
  Connecting,
}
 
class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => _serverStatus;

  late Socket _socket;
  Socket get socket => _socket;

  Function get emit => _socket.emit;
 
  void connect() async {

    final token = await AuthService.getToken();

    _socket = io(
      Environment.socketUrl,
      OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect() 
        .enableForceNew()
        .setExtraHeaders({
          'x-token': token
        })
        .build()
    );
 
    _socket.onConnect((_) {
      _socket.emit('mensaje', 'Conectado desde la app de Flutter');
      print('Cliente conectado');

      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
 
    _socket.onDisconnect((_) {

      // _socket.emit('mensaje', 'Desconectado desde la app de Flutter');
      print('Cliente desconectado');

      _serverStatus = ServerStatus.Offline;
      notifyListeners();

    });

  }


  void disconnect() {
    _socket.disconnect();
  }

}