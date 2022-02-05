// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/venta/ingresar_editar_venta.dart';
import 'package:produlacmovil/pages/views/ventasView.dart';

import '../../listas.dart';

class SubMenuVentas extends StatefulWidget {
  SubMenuVentas({Key? key}) : super(key: key);

  @override
  _SubMenuVentasState createState() => _SubMenuVentasState();
}

class _SubMenuVentasState extends State<SubMenuVentas> {
  List animalesLista = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Ventas'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.0438,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Realizar Venta",
    img: "assets/images/ventas.png",
    ruta: 'realizarVentas',
  );

  Items item2 = Items(
    title: "Ver ventas",
    img: "assets/images/registrado.png",
    ruta: 'verVentas',
  );
  /* Items item3 = Items(
    title: "Deceso",
    img: "assets/images/map.png",
    ruta: 'vacunar',
  );
  Items item4 = Items(
    title: "Parto",
    img: "assets/images/festival.png",
    ruta: 'vacunar',
  );
 Items item5 = Items(
    title: "To do",
    img: "assets/images/todo.png",
  );
  Items item6 = Items(
    title: "Settings",
    img: "assets/images/setting.png",
  ); */

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
                //Navigator.pushNamed(context, data.ruta);
                //print('enviar a ruta ' + data.ruta);
                // ignore: non_constant_identifier_names
                List<dynamic> lista_animales = [];
                  if (rol_id_usuario_logeado == "1") {
                    lista_animales = await listaAnimales();
                  } else {
                    lista_animales = await listaAnimalesporfinca();
                  }
                if (data.ruta == 'realizarVentas') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngresarEditarVenta(
                          0, 0, '', 0, '', '', '', '', '', lista_animales),
                    ),
                  );
                } else if (data.ruta == 'verVentas') {
                  List<dynamic> lista_ventas =
                      await getVentasPorFinca(fin_id_usuario_logeado);

                  if (lista_ventas.length >= 1) {
                    if (lista_ventas[0] == 400) {
                      lista_ventas = [];
                    }
                  }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VisualizarVentas(lista_ventas)));
                }
                /* else if (data.ruta == 'vacunar') {
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
                } */
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
