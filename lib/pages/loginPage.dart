//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names, deprecated_member_use



import 'package:flutter/material.dart';
import 'package:produlacmovil/components/background.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/seleccionfincaatrabajar.dart';
import 'dart:convert';

import 'drawer/navigation_home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controllerUser = TextEditingController();
  final _controllerPassword = TextEditingController();
  bool _mostrarDialogInicio = true;
  bool _mostrarErrorUsuario = false;

  ControllerGenral controller_general = new ControllerGenral();
  String select_fin_id_veterinario = "";

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets

    _controllerUser.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGround(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '''Bienvenido a ProduLac'''.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.0292),
              TextField(
                controller: _controllerUser,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.0292),
/*               Container(
                alignment: Alignment.centerRight,
                child: const Text(
                  'Olvidaste tu contraseña?',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ), */

              Visibility(
                  visible: _mostrarErrorUsuario,
                  child: Text(
                    'Contraseña o usuario incorrectos',
                    style: TextStyle(color: Colors.red),
                  )),
              SizedBox(height: size.height * 0.0731),
              RaisedButton(
                onPressed: () async {
                  dialogInicioSesion(context);
                  await enviarDatosLogin(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ],
                    ),
                  ),
                  child: const Text('Iniciar Sesión',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
              ),
              SizedBox(height: size.height * 0.0292),
/*               Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '''No tienes una cuenta?''',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: size.width * 0.0243),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    ),
                    child: const Text(
                      'Registrate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ), */
            ],
          ),
        ),
      ),
    );
  }

  Future<void> enviarDatosLogin(BuildContext context) async {
    String encodebody = jsonEncode({
      "per_usuario": _controllerUser.text,
      "per_contraseña": _controllerPassword.text,
    });

    List datos = await controller_general.httpgeneral(
        ip_server + "login", "POST", encodebody);
    bool verificar = controller_general.errorestoken(datos);
    if (verificar) {
      Navigator.pop(context);
      print("enviar a la url del login");

      _mostrarDialogInicio = false;
      setState(() {
        _mostrarErrorUsuario = true;
      });
    } else {
      _mostrarDialogInicio = false;
      _mostrarErrorUsuario = false;

      if(rol_id_usuario_logeado=="1"){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => NavigationHomeScreen(),
          ),
        );
      }else{
        List fincas_segun_per_id = await listaFincasSegunPerID();
      List fincas_per_id = listaFincasPerId(fincas_segun_per_id);
      print(fincas_per_id);
      if (fincas_per_id.length == 1) {
        fin_id_usuario_logeado = fincas_per_id[0]['fin_id'].toString();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => NavigationHomeScreen(),
          ),
        );
      } else {
        if (fincas_per_id.length >= 2) {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SeleccioneFincaATrabajar(fincas_per_id),
          ),
        );
        }
      }
    }
      }
    _controllerPassword.clear();
    _controllerUser.clear();
  }

  Future<dynamic> dialogInicioSesion(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          width: size.width * 0.4861,
          height: size.height * 0.1463,
          child: Column(
            children: [
              Container(
                height: size.width * 0.1458,
                width: size.height * 0.0878,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Iniciado Sesión'))
            ],
          ),
        ),
      ),
    );
  }

  
}
