// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/catalogo/ingresar_editar_catalogo.dart';
import 'package:produlacmovil/pages/deceso/ingresar_editar_deceso.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/fincapersona/ingresar_editar_finca_persona.dart';
import 'package:produlacmovil/pages/item/insertar_actualizar_item.dart';
import 'package:produlacmovil/pages/persona/ingresar_editar_persona.dart';
import 'package:produlacmovil/pages/views/catalogoView.dart';
import 'package:produlacmovil/pages/views/decesoView.dart';
import 'package:produlacmovil/pages/views/fincaView.dart';
import 'package:produlacmovil/pages/views/fincapersonaView.dart';
import 'package:produlacmovil/pages/views/inseminacionporfinca.dart';
import 'package:produlacmovil/pages/views/itemcatalogoView.dart';
import 'package:produlacmovil/pages/views/partoGlobal.dart';
import 'package:produlacmovil/pages/views/personaView.dart';
import 'package:produlacmovil/pages/views/prodGlobalView.dart';
import 'package:produlacmovil/pages/views/prodIndividual.dart';

class SubMenuAdministrar extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SubMenuAdministrar({Key? key}) : super(key: key);

  @override
  _SubMenuAdministrarState createState() => _SubMenuAdministrarState();
}

class _SubMenuAdministrarState extends State<SubMenuAdministrar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Administrador'),
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
    title: "Agregar Usuario",
    img: "assets/images/usuario.png",
    ruta: 'AgregarUsuario',
  );

  Items item2 = Items(
    title: "Ver usuarios",
    img: "assets/images/verRegistro2.png",
    ruta: 'personasView',
  );
  Items item3 = Items(
    title: "Agregar Catalogo",
    img: "assets/images/catalogo.png",
    ruta: 'AgregarCatalogo',
  );
  Items item4 = Items(
    title: "Agregar Item Catalogo",
    img: "assets/images/item.png",
    ruta: 'AgregarItemCatalogo',
  );
  Items item5 = Items(
    title: "Agregar Finca",
    img: "assets/images/terreno.png",
    ruta: 'AgregarFinca',
  );
  Items item6 = Items(
    title: "Ver Fincas",
    img: "assets/images/verRegistro2.png",
    ruta: 'verfincas',
  );
  Items item7 = Items(
    title: "Agregar Fincas Persona",
    img: "assets/images/agregarUsuario.png",
    ruta: 'Agregarfincaspersona',
  );

  Items item8 = Items(
    title: "Deceso",
    img: "assets/images/craneo.png",
    ruta: 'deceso',
  );

  Items item9 = Items(
    title: "Ver Decesos",
    img: "assets/images/verRegistro2.png",
    ruta: 'verDeceso',
  );

  Items item10 = Items(
    title: "Ver Catalogo",
    img: "assets/images/verRegistro2.png",
    ruta: 'verCatalogo',
  );

  Items item11 = Items(
    title: "Ver Item",
    img: "assets/images/verRegistro2.png",
    ruta: 'verItemCatalogo',
  );

  Items item12 = Items(
    title: "Ver Finca Persona",
    img: "assets/images/verRegistro2.png",
    ruta: 'verfincapersona',
  );

  Items item13 = Items(
    title: "Ver Produccion Global",
    img: "assets/images/verRegistro2.png",
    ruta: 'verproduccionglobal',
  );
  Items item14 = Items(
    title: "Ver Produccion Individual",
    img: "assets/images/verRegistro2.png",
    ruta: 'verproduccionIndividual',
  );

  Items item15 = Items(
    title: "Ver Inseminacion Global",
    img: "assets/images/verRegistro2.png",
    ruta: 'verinseminacionglobal',
  );

  Items item16 = Items(
    title: "Ver Parto Global",
    img: "assets/images/verRegistro2.png",
    ruta: 'verpartoglobal',
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Items> listaAdmin = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item10,
      item11,
      item12
    ];
    List<Items> listaDueno = [item1, item2, item13, item14, item8, item9,item15,item16];
    List<Items> listaEmpleado = [item13, item14, item8, item9];
    List<Items> listaVeterinario = [item8, item9,item15,item16];
    List<Items> lista_recorrer = [];
    if (rol_id_usuario_logeado == "1") {
      lista_recorrer = listaAdmin;
    } else {
      if (rol_id_usuario_logeado == "2") {
        lista_recorrer = listaDueno;
      } else {
        if (rol_id_usuario_logeado == "3") {
          lista_recorrer = listaVeterinario;
        } else {
          if (rol_id_usuario_logeado == "4") {
            lista_recorrer = listaEmpleado;
          }
        }
      }
    }
    var color = 0xFF70C3FA;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: lista_recorrer.map((data) {
            return GestureDetector(
              onTap: () async {
                if (data.ruta == "AgregarUsuario") {
                  List lista_rol = await getRoles();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IngresarEditarPersona(
                          0, "", "", "", "", "", "", "", "", "", 0, lista_rol),
                    ),
                  );
                }

                if (data.ruta == "personasView") {
                  List lista_fincapersonas = [];
                  if (rol_id_usuario_logeado == "1") {
                    //Trae todas las personas de todas las fincas
                    lista_fincapersonas = await getTodosFincasPersonas();
                  } else {
                    if (rol_id_usuario_logeado == "2") {
                      //trae a todas las personas de una finca
                      lista_fincapersonas =
                          await getTodosFincasPersonadeunafinca(
                              fin_id_usuario_logeado);
                    }
                  }
                  if(lista_fincapersonas.length>=1){
                    if(lista_fincapersonas[0]==400){
                    lista_fincapersonas=[];
                  }
                  }
                  

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VisualizarPersonas(lista_fincapersonas),
                    ),
                  );
                }

                if (data.ruta == "AgregarCatalogo") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IngresarEditarCatalogo(0, ""),
                    ),
                  );
                }

                if (data.ruta == "AgregarItemCatalogo") {
                  List lista_catalogos = await getTodosCatalogos();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          IngresarEditarItem(0, "", 0, lista_catalogos),
                    ),
                  );
                }

                if (data.ruta == "AgregarFinca") {
                  List lista_personas = await listapersonas();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IngresarEditarFinca(
                          0, "", "", "", "", "", "", "", "", lista_personas),
                    ),
                  );
                }
                if (data.ruta == "verfincas") {
                  List fincas = await listaTodaslasfincas();
                  if(fincas.length>=1){
                    if(fincas[0]==400){
                    fincas=[];
                  }
                  }
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VisualizarFinca(fincas),
                    ),
                  );
                }

                if (data.ruta == "Agregarfincaspersona") {
                  List fincas = await listaTodaslasfincas();
                  List lista_personas = await listapersonas();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IngresarEditarFincaPersona(
                          0, 0, 0, fincas, lista_personas),
                    ),
                  );
                }

                if (data.ruta == 'deceso') {
                  List<dynamic> lista_animales = [];
                  if (rol_id_usuario_logeado == "1") {
                    lista_animales = await listaAnimales();
                  } else {
                    lista_animales = await listaAnimalesporfinca();
                  }
                  print('ruta');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngresarEditarDeceso(
                              0, 0, '', '', '', lista_animales)));
                }

                if (data.ruta == "verDeceso") {
                  List lista = await getDecesoporFinca(fin_id_usuario_logeado);

                  
                  if(lista.length>=1){
                      if(lista[0]==400){
                    lista=[];
                  }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualizarDeceso(lista)));
                }

                if (data.ruta == "verCatalogo") {
                  List lista = await getTodosCatalogos();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualizarCatalogo(lista)));
                }
                if (data.ruta == "verItemCatalogo") {
                  List lista = await getItems();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualizarItemCatalogo(lista)));
                }

                if (data.ruta == "verfincapersona") {
                  List lista = await getTodosFincasPersonas();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualizarFincaPersona(lista)));
                }

                if (data.ruta == "verproduccionglobal") {
                  List lista =
                      await getListaProdGlobalporfinca(fin_id_usuario_logeado);
                  
                  if(lista.length>=1){
                    if(lista[0]==400){
                    lista=[];
                  }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualizarProdGlobal(lista)));
                }

                if (data.ruta == "verproduccionIndividual") {
                  List lista = await getListaProdIndividualporfinca(
                      fin_id_usuario_logeado);
                  if(lista.length>=1){
                    if(lista[0]==400){
                    lista=[];
                  }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VisualizarProdIndividual(lista)));
                }
                if(data.ruta=="verinseminacionglobal"){
                  List lista = await getInseminacionPorFinca();
                  if(lista.length>=1){
                    if(lista[0]==400){
                    lista=[];
                  }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VisualizarInseminacionFinca(lista)));

                }
                if(data.ruta=="verpartoglobal"){
                   List lista = await getPartoPorFinca();
                  if(lista.length>=1){
                    if(lista[0]==400){
                    lista=[];
                  }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VisualizarPartoGlobal(lista)));
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
