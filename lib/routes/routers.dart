// ignore_for_file: prefer_const_constructors

import 'package:chat/pages/pages.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios'  : (_) => UsuariosPage(),
  'chat'      : (_) => ChatPage(),
  'login'     : (_) => LoginPage(),
  'register'  : (_) => RegisterPage(),
  'loading'   : (_) => LoadingPage(),

}; 