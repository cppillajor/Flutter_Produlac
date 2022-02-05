import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/tratamiento/ingresar_editar_tratamiento.dart';

class VisualizarTratamiento extends StatefulWidget {
  List datos;

  VisualizarTratamiento(this.datos);
  @override
  _VisualizarTratamientoState createState() =>
      new _VisualizarTratamientoState();
}

class _VisualizarTratamientoState extends State<VisualizarTratamiento> {
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
        title: Text('TABLA TRATAMIENTO'),
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
                          .where((element) => (element['tra_fecha']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['tra_descripcion']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['tra_diastratamiento']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['tra_medicamento']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element['tra_diagnostico']
                                  .toLowerCase()
                                  .contains(value.toLowerCase())  ||
                              element["tbl_animale"]["ani_nombre"]
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
                                  'Imagen',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nombre animal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Fecha',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Diagnostico',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Medicamento',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Dias Tratamiento',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Descripcion',
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
                                          DataCell(CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                element["tbl_animale"]
                                                    ["ani_imagen"]),
                                          )),
                                          DataCell(Text(element["tbl_animale"]
                                              ["ani_nombre"])),
                                          DataCell(Text(element["tra_fecha"])),
                                          DataCell(
                                              Text(element["tra_diagnostico"])),
                                          DataCell(
                                              Text(element["tra_medicamento"])),
                                          DataCell(Text(
                                              element["tra_diastratamiento"])),
                                          DataCell(
                                              Text(element["tra_descripcion"])),
                                          DataCell(
                                            rol_id_usuario_logeado!="4"?
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    List lista = [];
                                                    if (rol_id_usuario_logeado ==
                                                        "1") {
                                                      lista =
                                                          await listaAnimales();
                                                    } else {
                                                      lista =
                                                          await listaAnimalesporfinca();
                                                    }
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => IngresarEditarTratamiento(
                                                              int.parse(element["tra_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "tra_fecha"],
                                                              int.parse(element[
                                                                          "ani_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "tra_diagnostico"],
                                                              element[
                                                                  "tra_medicamento"],
                                                              element[
                                                                  "tra_diastratamiento"],
                                                              element[
                                                                  "tra_descripcion"],
                                                              lista)),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ):Text(""),
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
}
