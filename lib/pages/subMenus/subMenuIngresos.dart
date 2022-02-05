// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/ingresoegreso/ingresar_editar_ingreso_egreso.dart';
import 'package:produlacmovil/pages/views/ingresosegresosView.dart';

import '../../listas.dart';

class SubMenuIngresos extends StatefulWidget {
  SubMenuIngresos({Key? key}) : super(key: key);

  @override
  _SubMenuIngresosState createState() => _SubMenuIngresosState();
}

class _SubMenuIngresosState extends State<SubMenuIngresos> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Ingresos'),
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
    title: "Realizar Ingreso",
    img: "assets/images/ingresos.png",
    ruta: 'realizarIngreso',
  );

  Items item2 = Items(
    title: "Ver ingresos",
    img: "assets/images/registrado.png",
    ruta: 'verIngreso',
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
                List<dynamic> fincas = await listaFincasSegunPerID();
                List<dynamic> listaIE = await listaIngresoEgreso();
                List<dynamic> fincaEnviar = listaFincasPerId(fincas);
                //lista_fincas_segun_per_id
                if (data.ruta == 'realizarIngreso') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngresarEditarIngresoEgreso(
                          0, 0, 0, 0, '', '', listaIE, fincaEnviar),
                    ),
                  );
                } /* else if (data.ruta == 'vacunar') {
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

                if (data.ruta == "verIngreso") {
                  List lista_ingresos_egresos =
                      await getIngresosEgresosPorFinca(fin_id_usuario_logeado);

                  if (lista_ingresos_egresos.length >= 1) {
                    if (lista_ingresos_egresos[0] == 400) {
                      lista_ingresos_egresos = [];
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VisualizarIngresosEgresos(lista_ingresos_egresos),
                    ),
                  );
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
