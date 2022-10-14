import 'package:flutter/material.dart';

import 'package:chat/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
   
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  
                const Logo(titulo: 'Login',),
                _Form(),
                const Labels(ruta: 'register', titulo: '¿No tienes cuenta?', subtitulo: '¡Crea una ahora!',),

                const Text('Términos y condiciones de uso', style: TextStyle(color: Colors.black38, fontSize: 11)),
                const SizedBox(height: 1.0)
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 40, bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),

      child: Column(
        children: [

          CustomInput(
            icon: Icons.mail_outline, 
            placeholder: 'Correo electrónico', 
            textController: emailCtrl,
            textKeyboardType: TextInputType.emailAddress,
          ),

          CustomInput(
            icon: Icons.lock_outline, 
            placeholder: 'Contraseña', 
            textController: passCtrl,
            isPassword: true,
          ),

          BotonAzul(text: 'Ingresar', onPressed: (){
            print(emailCtrl.text);
            print(passCtrl.text);
            
          }),

        
          
        ],
      ),
    );
  }
}