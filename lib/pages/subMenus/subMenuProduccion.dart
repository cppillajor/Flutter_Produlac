// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/components/chartdefaultprodindividual.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/produccion/ingresar_editar_produccion_individual.dart';

import 'package:produlacmovil/pages/produccionindividualPage.dart';

class SubMenuProduccion extends StatefulWidget {
  SubMenuProduccion({Key? key}) : super(key: key);

  @override
  _SubMenuProduccionState createState() => _SubMenuProduccionState();
}

class _SubMenuProduccionState extends State<SubMenuProduccion> {
  List animalesLista = [];

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      animalesLista = ModalRoute.of(context)!.settings.arguments as List;
    }
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Producción del Animal'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          GridDashboard(animalesLista)
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  List animalesLista;
  GridDashboard(this.animalesLista);

  Items item1 = Items(
    title: "Registro de produccón diaria de leche",
    img: "assets/images/vacaOrd.png",
    ruta: 'reproducciondiarialeche',
  );

  Items item2 = Items(
    title: "Ver registro de producción",
    img: "assets/images/registrado.png",
    ruta: 'verregistrodeproduccion',
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
                if (data.ruta == "reproducciondiarialeche") {
                  List<dynamic> lista_animales = [];
                  if (rol_id_usuario_logeado == "1") {
                    lista_animales = await listaAnimales();
                  } else {
                    lista_animales = await listaAnimalesporfinca();
                  }
                  List lista_horario = await getlistaHorario();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngresarEditarIndividual(
                              0,
                              animalesLista[0]['ani_id'],
                              "",
                              "",
                              "",
                              "",
                              lista_animales,
                              lista_horario)));
                }
                if (data.ruta == "verregistrodeproduccion") {
                  if (animalesLista[0]['ani_id'] != null &&
                      animalesLista[0]['ani_id'].toString() != "" &&
                      animalesLista[0]['ani_id'].toString() != "0") {
                    List fecha_litros = await listaprodIndividual(
                        animalesLista[0]['ani_id'].toString());

                    if (fecha_litros.length >= 1) {
                      if (fecha_litros[0] == 400) {
                        fecha_litros = [];
                      }
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProduccionIndividualPage(fecha_litros)));
                  }
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
