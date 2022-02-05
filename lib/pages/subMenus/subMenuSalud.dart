// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/tratamiento/ingresar_editar_tratamiento.dart';
import 'package:produlacmovil/pages/vacuna/ingresar_editar_vacuna.dart';
import 'package:produlacmovil/pages/views/tratamientoView.dart';
import 'package:produlacmovil/pages/views/vacunaView.dart';

import '../../listas.dart';

class SubMenuSalud extends StatefulWidget {
  SubMenuSalud({Key? key}) : super(key: key);

  @override
  _SubMenuSaludState createState() => _SubMenuSaludState();
}

class _SubMenuSaludState extends State<SubMenuSalud> {
  List animalesLista = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      animalesLista = ModalRoute.of(context)!.settings.arguments as List;
      //var listaA = jsonDecode(objeto);
      print(animalesLista[0]['ani_id']);
    }

    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Salud del Animal'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.0438,
          ),
          GridDashboard(animalesLista)
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  List animalesLista = [];

  GridDashboard(this.animalesLista);

  Items item1 = Items(
    title: "Tratamiento Animal",
    img: "assets/images/registroMedicos.png",
    ruta: 'tratamiento',
  );

  Items item2 = Items(
    title: "Vacunar Animal",
    img: "assets/images/jeringuilla.png",
    ruta: 'vacunar',
  );
  Items item3 = Items(
    title: "Ver tratamientos",
    img: "assets/images/verRegistro2.png",
    ruta: 'verTratamiento',
  );

  Items item4 = Items(
    title: "Ver vacunas",
    img: "assets/images/verRegistro2.png",
    ruta: 'verVacunas',
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Items> myList = [];

    if(rol_id_usuario_logeado=="4"){
      myList = [item3];
    }else{
      myList = [item1, item2, item3, item4];
    }
     

    var color = 0xFF70C3FA;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () async {
                //Navigator.pushNamed(context, data.ruta);
                //print('enviar a ruta ' + data.ruta);
                // ignore: non_constant_identifier_names
                if (data.ruta == 'tratamiento') {
                  List<dynamic> lista_animales = [];
                  if (rol_id_usuario_logeado == "1") {
                    lista_animales = await listaAnimales();
                  } else {
                    lista_animales = await listaAnimalesporfinca();
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngresarEditarTratamiento(
                          0,
                          '',
                          animalesLista[0]['ani_id'],
                          '',
                          '',
                          '',
                          '',
                          lista_animales),
                    ),
                  );
                } else if (data.ruta == 'vacunar') {
                  List<dynamic> lista_animales = [];
                  if (rol_id_usuario_logeado == "1") {
                    lista_animales = await listaAnimales();
                  } else {
                    lista_animales = await listaAnimalesporfinca();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngresarEditarVacuna(
                          0,
                          '',
                          animalesLista[0]['ani_id'],
                          '',
                          '',
                          '',
                          lista_animales),
                    ),
                  );
                } else if (data.ruta == 'verTratamiento') {
                  List lista_tratamientos = await getTratamientoPorAnimal(
                      animalesLista[0]['ani_id'].toString());

                  if (lista_tratamientos.length >= 1) {
                    if (lista_tratamientos[0] == 400) {
                      lista_tratamientos = [];
                    }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VisualizarTratamiento(lista_tratamientos)));
                } else if (data.ruta == 'verVacunas') {
                  List lista_vacunas = await getVacunaPorAnimal(
                      animalesLista[0]['ani_id'].toString());

                  if (lista_vacunas.length >= 1) {
                    if (lista_vacunas[0] == 400) {
                      lista_vacunas = [];
                    }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VisualizarVacuna(lista_vacunas)));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: size.width * 0.1944,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
/*                     SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 14,
                    ), */
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String img;
  String ruta;
  Items({required this.title, required this.img, required this.ruta});
}
