import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/partoaborto/ingresareditaraborto.dart';
import 'package:produlacmovil/pages/partoaborto/ingresareditarparto.dart';
import 'package:produlacmovil/pages/produccion/ingresar_editar_produccion_global.dart';
import 'package:produlacmovil/pages/produccion/ingresar_editar_produccion_individual.dart';

class VisualizarProdIndividual extends StatefulWidget {
  List datos;
  VisualizarProdIndividual(this.datos);
  @override
  _VisualizarProdIndividualState createState() => new _VisualizarProdIndividualState();
}

class _VisualizarProdIndividualState extends State<VisualizarProdIndividual> {
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
        title: Text('TABLA PROD. Individual'),
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
                          .where((element) => (element['pro_fecha']
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["pro_litros"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["pro_dieta"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ani_nombre"]
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element["ite_nombre"]
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
                                  'Nombre Animal',
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
                                  'Litros',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Dieta',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Horario',
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
                                          DataCell(Text(element["pro_fecha"])),
                                          DataCell(Text(element["pro_litros"])),
                                          DataCell(Text(element["pro_dieta"])),
                                          DataCell(Text(element["ite_nombre"])),
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons
                                                      .edit),
                                                  iconSize: 30.0,
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    
                                                    List lista = await listaAnimalesporfinca();
                                                    List lista_horario = await getlistaHorario();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => IngresarEditarIndividual(
                                                              int.parse(element[
                                                                          "pro_id"]
                                                                      .toString())
                                                                  as int,
                                                              int.parse(element[
                                                                          "ani_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "pro_fecha"].toString(),
                                                              element[
                                                                  "ite_idhorario"].toString(),
                                                                  element[
                                                                  "pro_litros"].toString(),
                                                                  element[
                                                                  "pro_dieta"].toString(),
                                                              lista,lista_horario)),
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
