import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/catalogo/ingresar_editar_catalogo.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/item/insertar_actualizar_item.dart';
import 'package:produlacmovil/pages/tratamiento/ingresar_editar_tratamiento.dart';
import 'package:produlacmovil/pages/vacuna/ingresar_editar_vacuna.dart';

class VisualizarItemCatalogo extends StatefulWidget {
  List datos;

  VisualizarItemCatalogo(this.datos);
  @override
  _VisualizarItemCatalogoState createState() => new _VisualizarItemCatalogoState();
}

class _VisualizarItemCatalogoState extends State<VisualizarItemCatalogo> {
  TextEditingController buscar = new TextEditingController();
  List lista_datos = [];
  @override
  void initState() {
    lista_datos = widget.datos;
    print( widget.datos);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TABLA ITEM CATALOGO'),
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
                          .where((element) => (element['tbl_catalogo']['cat_nombre']
                              .toLowerCase()
                              .contains(value.toLowerCase())||element['ite_nombre']
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
                                  'Nombre Catalogo',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nombre Item',
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
                                          
                                          DataCell(Text(element["tbl_catalogo"]["cat_nombre"])), 
                                          DataCell(Text(element["ite_nombre"])),                                                                              
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.blue,
                                                  onPressed: () async {   
                                                    List lista = await getTodosCatalogos();                                                 
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => IngresarEditarItem(
                                                            
                                                              int.parse(element[
                                                                          "ite_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "ite_nombre"],
                                                              int.parse(element[
                                                                          "cat_id"]
                                                                      .toString())
                                                                  as int,lista
                                                                  )),
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
