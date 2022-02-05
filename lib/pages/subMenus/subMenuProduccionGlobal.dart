// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/components/chartdefaultprodindividual.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/produccion/fechas_produccion_global.dart';
import 'package:produlacmovil/pages/produccion/ingresar_editar_produccion_global.dart';
import 'package:produlacmovil/pages/produccion/ingresar_editar_produccion_individual.dart';
import 'package:produlacmovil/pages/produccionPage.dart';

import 'package:produlacmovil/pages/produccionindividualPage.dart';

class SubMenuProduccionGlobal extends StatefulWidget {
  SubMenuProduccionGlobal({Key? key}) : super(key: key);

  @override
  _SubMenuProduccionGlobal createState() => _SubMenuProduccionGlobal();
}

class _SubMenuProduccionGlobal extends State<SubMenuProduccionGlobal> {  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Producción Global'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {  

  Items item1 = Items(
    title: "Agregar Produccion Global",
    img: "assets/images/vacaOrd.png",
    ruta: 'AgregarProduccionGlobal',
  );

  Items item2 = Items(
    title: "ver producción global",
    img: "assets/images/registrado.png",
    ruta: 'verProduccionGlobal',
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Items> myList = [item1, item2];
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
                if (data.ruta == "AgregarProduccionGlobal") {
                  List lista_fincas_segun_per_id = await listaFincasSegunPerID();
                  List lista_fincas = listaFincasPerId(lista_fincas_segun_per_id);
                  List lista_horario = await getlistaHorario();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IngresarEditarProduccionGlobal(
                          0, "", "", "", "", "", lista_fincas, lista_horario),
                    ),
                  );                  
                }
                if (data.ruta == "verProduccionGlobal") {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FechasProduccionGlobal())); 
                                 
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
                      height: size.height * 0.02,
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
                    /*SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 14,
                    ),*/
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
