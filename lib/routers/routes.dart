//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:produlacmovil/pages/animalPage.dart';
import 'package:produlacmovil/pages/loginPage.dart';
import 'package:produlacmovil/pages/nacimientoPage.dart';
import 'package:produlacmovil/pages/principalPage.dart';

import 'package:produlacmovil/pages/produccionPage.dart';
import 'package:produlacmovil/pages/registerPage.dart';
import 'package:produlacmovil/pages/saludPage.dart';
import 'package:produlacmovil/pages/subMenus/subMenuAdministrar.dart';
import 'package:produlacmovil/pages/subMenus/subMenuProduccion.dart';
import 'package:produlacmovil/pages/subMenus/subMenuReproduccion.dart';
import 'package:produlacmovil/pages/subMenus/subMenuSalud.dart';
import 'package:produlacmovil/pages/tratamiento/ingresar_editar_tratamiento.dart';
import 'package:produlacmovil/pages/views/personaView.dart';

import '../main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => MyApp());
    case 'loginPage':
      return MaterialPageRoute(builder: (context) => LoginPage());
    case 'registroPage':
      return MaterialPageRoute(builder: (context) => RegisterPage());
    /*case 'animalPage':
      return MaterialPageRoute(builder: (context) => AnimalPAge());*/
    case 'saludPage':
      return MaterialPageRoute(builder: (context) => SaludPage());
    case 'nacimientoPage':
      return MaterialPageRoute(builder: (context) => NacimientoPage());
    /* case 'personasView':
      return MaterialPageRoute(builder: (context) => PersonaView()); */
    case 'subMenuSalud':
      return MaterialPageRoute(
          builder: (context) => SubMenuSalud(), settings: settings);
    case 'subMenuProduccion':
      return MaterialPageRoute(
          builder: (context) => SubMenuProduccion(), settings: settings);
    case 'subMenuAdministrar':
      return MaterialPageRoute(builder: (context) => SubMenuAdministrar());

    case 'subMenuReproduccion':
      return MaterialPageRoute(
          builder: (context) => SubMenuReproduccion(), settings: settings);
    default:
      return UnDefinedRoute();
  }
}

Route<dynamic> UnDefinedRoute() {
  return MaterialPageRoute(
      builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text('No route Found'),
            ),
            body: Center(
              child: Text("No Route Found 404"),
            ),
          ));
}
