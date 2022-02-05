import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/inseminacion/ingresar_editar_inseminacion.dart';
import 'package:produlacmovil/pages/partoaborto/ingresareditaraborto.dart';
import 'package:produlacmovil/pages/partoaborto/ingresareditarparto.dart';

class VisualizarInseminacion extends StatefulWidget {
  List datos;

  VisualizarInseminacion(this.datos);
  @override
  _VisualizarInseminacionState createState() =>
      new _VisualizarInseminacionState();
}

class _VisualizarInseminacionState extends State<VisualizarInseminacion> {
  TextEditingController buscar = new TextEditingController();
  List lista_datos = [];
  @override
  void initState() {
    lista_datos = widget.datos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TABLA INSEMINACION'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            child: ListView(
              children: <Widget>[
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
                      lista_datos = widget.datos
                          .where((element) => (element['ins_fechainseminacion']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ins_fechacomprobacion"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ins_cargada"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ins_tipoinseminacion"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ins_numpajuela"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ins_descripcion"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ani_id_padre_nombre"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ani_id_animal_nombre"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["per_nombre"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["per_apellido"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase())))
                          .toList();
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Fecha Inseminación',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nombre Padre',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nombre Animal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nombre Persona',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Fecha Comprobación',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Cargada',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Tipo Inseminación',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Número Pajuela',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Descripción',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Acciones',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                            rows: lista_datos
                                .map(
                                  ((element) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(element[
                                              "ins_fechainseminacion"])),
                                          DataCell(Text(
                                              element["ani_id_padre_nombre"])),
                                          DataCell(Text(
                                              element["ani_id_animal_nombre"])),
                                          DataCell(Text(element["per_nombre"] +
                                              " " +
                                              element["per_apellido"])),
                                          DataCell(Text(element[
                                              "ins_fechacomprobacion"])),
                                          DataCell(
                                              Text(element["ins_cargada"])),
                                          DataCell(Text(
                                              element["ins_tipoinseminacion"])),
                                          DataCell(
                                              Text(element["ins_numpajuela"])),
                                          DataCell(
                                              Text(element["ins_descripcion"])),
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons
                                                      .edit),
                                                  iconSize: 30.0,
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    List lista = [];
                                                    List lista_personas = [];
                                                    if (rol_id_usuario_logeado ==
                                                        "1") {
                                                      lista =
                                                          await listaAnimales();
                                                      lista_personas =
                                                          await listapersonas();
                                                    } else {
                                                      lista =
                                                          await listaAnimalesporfinca();
                                                      lista_personas =
                                                          await getTodosFincasPersonadeunafinca(
                                                              fin_id_usuario_logeado);
                                                    }
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => IngresarEditarInseminacion(
                                                              int.parse(element["ins_id"].toString())
                                                                  as int,
                                                              element[
                                                                  "ins_fechainseminacion"],
                                                              int.parse(element["per_id"].toString())
                                                                  as int,
                                                              int.parse(element["ani_id"].toString())
                                                                  as int,
                                                              element[
                                                                  "ins_fechacomprobacion"],
                                                              element[
                                                                  "ins_cargada"],
                                                              element[
                                                                  "ins_tipoinseminacion"],
                                                              int.parse(element["ani_idpadre"]
                                                                      .toString())
                                                                  as int,
                                                              int.parse(element[
                                                                      "ins_numpajuela"]
                                                                  .toString()) as int,
                                                              element["ins_descripcion"],
                                                              lista_personas,
                                                              lista)),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> dialog(
      BuildContext context, String mensaje, bool activar_acciones) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: [
          activar_acciones
              ? TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
              : Container()
        ],
        content: Container(
          width: 200,
          height: 100,
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                child: activar_acciones == false
                    ? CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    : Icon(
                        Icons.warning_sharp,
                        color: Colors.yellow,
                        size: 70,
                      ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mensaje,
                          style:
                              TextStyle(color: Color.fromRGBO(76, 172, 230, 1)),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
