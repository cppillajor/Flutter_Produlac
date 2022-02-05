//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names, sized_box_for_whitespace, avoid_unnecessary_containers, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:produlacmovil/components/categoriesAnimals.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

import 'package:produlacmovil/pages/onlyAnimalPage.dart';

import 'animal/ingresar_editar_animal.dart';

class AnimalPAge extends StatefulWidget {
  List animales_list;
  AnimalPAge(this.animales_list);

  @override
  _AnimalPAgeState createState() => _AnimalPAgeState();
}

class _AnimalPAgeState extends State<AnimalPAge> {
  TextEditingController buscar = new TextEditingController();
  ControllerGenral controller_general = new ControllerGenral();
  double value = 0;
  bool isSideBarOpen = false;
  List<dynamic> lista_animales = [];
  List<dynamic> lista_especie_animal = [];
  List<dynamic> lista_tipo_estado = [];
  List<dynamic> lista_fincas_per_id = [];
  List<dynamic> lista_fincas_segun_per_id = [];
  List lista_de_animales = [];
  @override
  void initState() {
    // TODO: implement initState
    lista_de_animales = widget.animales_list;
    print(lista_de_animales);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Pagina Principal'),
      ),
      body: Stack(
        children: [
          animalScreen(),
          //moveAnimation(),
        ],
      ),
    );
  }

  Widget animalScreen() {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        color: Color(0XffF5F2F5),
        child: Column(
          children: [
            rol_id_usuario_logeado == "2" || rol_id_usuario_logeado == "4"
                ? Container(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: RaisedButton(
                      onPressed: () async {
                        await enviarIngresarEditar(
                            0, '', '', '', '', '', '', '', 0, 0, '', 0, 0, 0);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        height: queryData.size.height * 0.0512,
                        width: queryData.size.width - 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(35, 144, 255, 1.0),
                              Color.fromRGBO(14, 57, 102, 1.0),
                            ],
                          ),
                        ),
                        child: const Text('Agregar nuevo animal',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  )
                : Text(''),            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'BUSCAR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            TextField(
              controller: buscar,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  fillColor: Colors.grey,
                  suffixIcon: Icon(Icons.search),
                  hintText: "BUSCAR",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              onChanged: (value) {
                setState(() {
                  lista_de_animales = widget.animales_list
                      .where((element) => (element['ani_nombre']
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element["ani_codigo"]
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element["ani_fechanacimiento"]
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element["ani_raza"]
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          element["ani_pesonacer"]
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                      .toList();
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                //height: queryData.size.height - 200,
                width: queryData.size.width,
                child: ListView.builder(
                  itemCount: lista_de_animales.length,
                  itemBuilder: (BuildContext context, int index) {
                    return animalItemWidget(
                        queryData,
                        lista_de_animales[index]['ani_imagen'],
                        lista_de_animales[index]['ani_nombre'],
                        lista_de_animales[index]['ani_codigo'],
                        lista_de_animales[index]['ani_sexo'],
                        lista_de_animales[index]['ani_raza'],
                        lista_de_animales[index]['ite_id_nombre_etapa'],
                        lista_de_animales[index]['ite_id_tipo_estado_nombre'],
                        [lista_de_animales[index]]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> enviarIngresarEditar(
      int ani_id,
      String ani_codigo,
      String ani_nombre,
      String ani_sexo,
      String ani_fechanacimiento,
      String ani_imagen,
      String ani_raza,
      String ite_idetapa,
      int ani_idpadre,
      int ani_idmadre,
      String ani_pesonacer,
      int ite_idespecie,
      int fin_id,
      int ite_id) async {
    dialogCargando(context);
    lista_fincas_segun_per_id = await listaFincasSegunPerID();
    lista_fincas_per_id = listaFincasPerId(lista_fincas_segun_per_id);
    List<dynamic> lista_animales = [];
    if (rol_id_usuario_logeado == "1") {
      lista_animales = await listaAnimales();
    } else {
      lista_animales = await listaAnimalesporfinca();
    }
    lista_especie_animal = await listaEspecieAnimal();
    lista_tipo_estado = await listaTipoEstado();
    List lista_etapa = await getEtapaAnimal();
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IngresarEditarAnimal(
            ani_id,
            ani_codigo,
            ani_nombre,
            ani_sexo,
            ani_fechanacimiento,
            ani_imagen,
            ani_raza,
            ite_idetapa,
            ani_idpadre,
            ani_idmadre,
            ani_pesonacer,
            ite_idespecie,
            fin_id,
            ite_id,
            lista_animales,
            lista_especie_animal,
            lista_fincas_per_id,
            lista_tipo_estado,
            lista_etapa),
      ),
    );
  }

  Container animalItemWidget(
      MediaQueryData queryData,
      String imagen,
      String nombreA,
      String codigoA,
      String sexoA,
      String raza,
      String etapa,
      String estado,
      List animalesLista) {
    // ignore: prefer_typing_uninitialized_variables

    return Container(
      //height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.only(bottom: 10.0),
      child: Slidable(
        direction: Axis.horizontal,
        startActionPane: ActionPane(
          extentRatio: 1.0,
          motion: ScrollMotion(),
          children: [
            rol_id_usuario_logeado == "2" || rol_id_usuario_logeado == "4"
                ? itemSlidableEditarAnimal('Editar', Color(0xDE0084FF),
                    Color(0xFFF1F1F1), FontAwesomeIcons.edit, animalesLista)
                : Text(''),

            /*itemSlidableEliminar('Eliminar', Color(0xDAFF0000),
                Color(0xFFFFFFFF), FontAwesomeIcons.trashAlt, animalesLista),*/
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 1.0,
          //openThreshold: 0.9,
          motion: ScrollMotion(),
          children: [
            rol_id_usuario_logeado == "2" ||
                    rol_id_usuario_logeado == "3" ||
                    rol_id_usuario_logeado == "4"
                ? itemSlidable('Salud', Color(0xD52BCA2B), Color(0xFF000000),
                    FontAwesomeIcons.fileMedical, 'subMenuSalud', animalesLista)
                : Text(''),
            rol_id_usuario_logeado == "2" || rol_id_usuario_logeado == "4"
                ? itemSlidable(
                    'Producción',
                    Color(0xCE6CB1FF),
                    Color(0xFF000000),
                    FontAwesomeIcons.clipboard,
                    'subMenuProduccion',
                    animalesLista)
                : Text(''),
            itemSlidable(
                'Reproducción',
                Color(0xCEFDFF6C),
                Color(0xFF000000),
                FontAwesomeIcons.clipboard,
                'subMenuReproduccion',
                animalesLista),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => onlyAnimalPage(animalesLista)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    height: queryData.size.height * 0.2048,
                    width: queryData.size.width * 0.316,
                    //padding: EdgeInsets.only(top: 40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(imagen), fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: queryData.size.width,
                      height: queryData.size.height * 0.2048,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadowList,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          /*                                   bottomLeft: Radius.circular(20.0),
                                        topLeft: Radius.circular(20.0), */
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(nombreA),
                          Text("Codigo: $codigoA"),
                          Text("Sexo: $sexoA"),
                          Text("Raza: $raza"),
                          Text("Etapa: $etapa"),
                          Text("Estado: $estado"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SlidableAction itemSlidable(String textItem, Color colorFondo,
      Color colorTexto, IconData iconoItem, String ruta, List animalesLista) {
    return SlidableAction(
      // An action can be bigger than the others.
      flex: 1,
      onPressed: (context) {
        Navigator.pushNamed(context, ruta, arguments: animalesLista);
      },
      backgroundColor: colorFondo,
      foregroundColor: colorTexto,
      icon: iconoItem,
      label: textItem,
    );
  }

  /*SlidableAction itemSlidableEliminar(String textItem, Color colorFondo,
      Color colorTexto, IconData iconoItem, List animal) {
    return SlidableAction(
      // An action can be bigger than the others.
      flex: 1,
      onPressed: (context) {
        eliminar_animal(animal);
      },
      backgroundColor: colorFondo,
      foregroundColor: colorTexto,
      icon: iconoItem,
      label: textItem,
    );
  }*/

  /*Future<void> eliminar_animal(List animal) async {
    if (animal[0]['ani_id'] != null) {
      await controller_general.httpgeneral(
          ip_server + "animales/" + animal[0]['ani_id'].toString(),
          "DELETE",
          "");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => AnimalPAge()));
    }
  }*/

  SlidableAction itemSlidableEditarAnimal(String textItem, Color colorFondo,
      Color colorTexto, IconData iconoItem, List animales) {
    return SlidableAction(
      // An action can be bigger than the others.
      flex: 1,
      onPressed: (context) async {
        await enviarIngresarEditar(
            animales[0]['ani_id'],
            animales[0]['ani_codigo'],
            animales[0]['ani_nombre'],
            animales[0]['ani_sexo'],
            animales[0]['ani_fechanacimiento'],
            animales[0]['ani_imagen'],
            animales[0]['ani_raza'],
            animales[0]['ite_id_etapa'].toString(),
            animales[0]['ani_id_padre'],
            animales[0]['ani_id_madre'],
            animales[0]['ani_pesonacer'],
            animales[0]['ite_id_especie'],
            animales[0]['fin_id'],
            animales[0]['ite_id_tipo_estado']);
      },
      backgroundColor: colorFondo,
      foregroundColor: colorTexto,
      icon: iconoItem,
      label: textItem,
    );
  }

  Container categoriesWidget() {
    return Container(
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadowList,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    categories[index]['iconPath'],
                    height: 50.0,
                    width: 50.0,
                    color: Colors.grey[700],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 18.0, top: 5.0),
                    child: Text(categories[index]['name'])),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> dialogCargando(BuildContext context) {
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
                height: size.height * 0.0878,
                width: size.width * 0.1458,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20), child: Text('Cargando...'))
            ],
          ),
        ),
      ),
    );
  }
}

class PageArguments {
  final int id;
  final String title;
  PageArguments({required this.id, required this.title});
}
