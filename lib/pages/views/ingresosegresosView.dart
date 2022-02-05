import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/ingresoegreso/ingresar_editar_ingreso_egreso.dart';
import 'package:produlacmovil/pages/tratamiento/ingresar_editar_tratamiento.dart';
import 'package:produlacmovil/pages/vacuna/ingresar_editar_vacuna.dart';

class VisualizarIngresosEgresos extends StatefulWidget {
  List datos;

  VisualizarIngresosEgresos(this.datos);
  @override
  _VisualizarIngresosEgresosState createState() => new _VisualizarIngresosEgresosState();
}

class _VisualizarIngresosEgresosState extends State<VisualizarIngresosEgresos> {
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
        title: Text('TABLA INGRESO, EGRESO'),
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
                          .where((element) => (element['ing_fecha']
                              .toLowerCase()
                              .contains(value.toLowerCase())|| element['tbl_finca']['fin_nombre']
                              .toLowerCase()
                              .contains(value.toLowerCase())||element['ing_monto']
                              .toLowerCase()
                              .contains(value.toLowerCase())||element['tbl_item']['ite_nombre']
                              .toLowerCase()
                              .contains(value.toLowerCase())|| element["ing_descripcion"]
                              .toLowerCase()
                              .contains(value.toLowerCase())|| element["ing_fecha"]
                              .toLowerCase()
                              .contains(value.toLowerCase())
                          ))
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
                                  'Nombre Finca',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Tipo',
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
                                  'Descripción',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Monto',
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
                                                element["tbl_finca"]["fin_imagen"]),
                                          )),
                                          DataCell(Text(element["tbl_finca"]["fin_nombre"])),
                                          DataCell(
                                              Text(element['tbl_item']["ite_nombre"])),
                                          DataCell(
                                              Text(element["ing_fecha"])),
                                          DataCell(Text(element["ing_descripcion"])),
                                          DataCell(
                                              Text(element["ing_monto"])),                                        
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    List lista_ingreso_egreso= await listaIngresoEgreso();


                                                    List lista = await listaFincasSegunPerID();
                                                    List lista_fincas= listaFincasPerId(lista);

                                                    
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => IngresarEditarIngresoEgreso(
                                                              int.parse(element[
                                                                          "ing_id"]
                                                                      .toString())
                                                                  as int,
                                                              int.parse(element[
                                                                          "ing_monto"]
                                                                      .toString())
                                                                  as int,
                                                              int.parse(element[
                                                                          "ite_idingresoegreso"]
                                                                      .toString())
                                                                  as int,
                                                              int.parse(element[
                                                                          "fin_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "ing_descripcion"],
                                                              element[
                                                                  "ing_fecha"],
                                                              lista_ingreso_egreso,lista_fincas)),
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
}
