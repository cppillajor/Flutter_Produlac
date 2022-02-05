import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';

class VisualizarFinca extends StatefulWidget {
  List datos;

  VisualizarFinca(this.datos);
  @override
  _VisualizarFincaState createState() => new _VisualizarFincaState();
}

class _VisualizarFincaState extends State<VisualizarFinca> {
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
        title: Text('TABLA FINCA'),
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
                          .where((element) => (element['fin_nombre']
                              .toLowerCase()
                              .contains(value.toLowerCase()) || element["tbl_persona"]["per_nombre"]
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
                                  'Dueño',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
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
                                  'Nombre',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Extención',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'País',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Provincia',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Ciudad',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Teléfono',
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
                                          DataCell(Text(element["tbl_persona"]["per_nombre"])),
                                          DataCell(CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                element["fin_imagen"]),
                                          )),
                                          DataCell(Text(element["fin_nombre"])),
                                          DataCell(
                                              Text(element["fin_extension"])),
                                          DataCell(Text(element["fin_pais"])),
                                          DataCell(
                                              Text(element["fin_provincia"])),
                                          DataCell(Text(element["fin_ciudad"])),
                                          DataCell(
                                              Text(element["fin_telefono"])),
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.black,
                                                  onPressed: () async {

                                                    List lista=[];
                                                        if(rol_id_usuario_logeado=="1"){
                                                          lista = 
                                                        await listapersonas();
                                                        }else{
                                                          lista= await getTodosFincasPersonadeunafinca(fin_id_usuario_logeado);
                                                        }


                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => IngresarEditarFinca(
                                                              int.parse(element[
                                                                          "fin_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "fin_nombre"],
                                                              element[
                                                                  "fin_extension"],
                                                              element[
                                                                  "fin_imagen"],
                                                              element[
                                                                  "fin_pais"],
                                                              element[
                                                                  "fin_provincia"],
                                                              element[
                                                                  "fin_ciudad"],
                                                              element[
                                                                  "fin_telefono"],
                                                              element["per_id"].toString(),
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
