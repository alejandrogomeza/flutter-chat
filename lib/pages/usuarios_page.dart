import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';


import 'package:chat/services/auth_service.dart';
import 'package:chat/models/models.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController =
    RefreshController(initialRefresh: false);


  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: '1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Andres', email: '2@test.com', online: false),
    Usuario(uid: '3', nombre: 'Juan', email: '3@test.com', online: true),
    Usuario(uid: '4', nombre: 'Juliana', email: '4@test.com', online: false),
    Usuario(uid: '5', nombre: 'Arroz', email: '5@test.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(usuario?.nombre ?? 'No name', style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.black87,),
          onPressed: (){
            //TODO Desconectarnos del socket server
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 0),
            child: const Icon(Icons.check_circle, color: Colors.blue),

          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        // enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: const WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.green,),
          waterDropColor: Colors.blue,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder: (_, i) => const Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0,2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _refreshController.refreshCompleted();
  }




}