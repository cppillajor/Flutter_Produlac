import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/tratamiento/ingresar_editar_tratamiento.dart';
import 'package:produlacmovil/pages/vacuna/ingresar_editar_vacuna.dart';
import 'package:produlacmovil/pages/venta/ingresar_editar_venta.dart';

class VisualizarVentas extends StatefulWidget {
  List datos;

  VisualizarVentas(this.datos);
  @override
  _VisualizarVentasState createState() => new _VisualizarVentasState();
}

class _VisualizarVentasState extends State<VisualizarVentas> {
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
        title: Text('TABLA VENTAS'),
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
                          .where((element) => (element['per_nombre']
                              .toLowerCase()
                              .contains(value.toLowerCase())|| element['per_apellido']
                              .toLowerCase()
                              .contains(value.toLowerCase())||element['ven_comprador']
                              .toLowerCase()
                              .contains(value.toLowerCase())||element['ven_telcomprador']
                              .toLowerCase()
                              .contains(value.toLowerCase())|| element["ven_cedulacomprador"]
                              .toLowerCase()
                              .contains(value.toLowerCase())|| element["ven_direccioncomprador"]
                              .toLowerCase()
                              .contains(value.toLowerCase())|| element["ani_nombre"]
                              .toLowerCase()
                              .contains(value.toLowerCase())|| element["ven_valor"]
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
                                  'Imagen Animal',
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
                                  'Nombre vendedor',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nombre Comprador',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Teléfono Comprador',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Cedula Comprador',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),                             
                              DataColumn(
                                label: Text(
                                  'Dirección Comprador',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Valor',
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
                                                element["ani_imagen"]),
                                          )),
                                          DataCell(Text(element["ani_nombre"])),
                                          DataCell(
                                              Text(element["ven_fecha"])),
                                          DataCell(
                                              Text(element["per_nombre"]+" "+element["per_apellido"])),
                                          DataCell(
                                              Text(element["ven_comprador"])),
                                          DataCell(Text(element["ven_telcomprador"])),
                                          DataCell(
                                              Text(element["ven_cedulacomprador"])),
                                          DataCell(
                                              Text(element["ven_direccioncomprador"])),
                                          DataCell(
                                              Text(element["ven_valor"])),                                                                               
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    List lista = [];
                                                    if(rol_id_usuario_logeado=="1"){
                                                      lista = await listaAnimales();
                                                    }else{
                                                      lista = await listaAnimalesporfinca();
                                                    }
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => IngresarEditarVenta(
                                                              int.parse(element[
                                                                          "ven_id"]
                                                                      .toString())
                                                                  as int,
                                                              int.parse(element[
                                                                          "ani_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "ven_fecha"],
                                                              int.parse(element[
                                                                          "per_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "ven_comprador"],
                                                              element[
                                                                  "ven_telcomprador"],
                                                              element[
                                                                  "ven_cedulacomprador"],
                                                              element[
                                                                  "ven_direccioncomprador"],
                                                              element[
                                                                  "ven_valor"].toString(),
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
}
