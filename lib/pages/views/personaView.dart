import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/persona/ingresar_editar_persona.dart';

class VisualizarPersonas extends StatefulWidget {
  List datos;

  VisualizarPersonas(this.datos);
  @override
  _VisualizarPersonasState createState() => new _VisualizarPersonasState();
}

class _VisualizarPersonasState extends State<VisualizarPersonas> {
  TextEditingController buscar = new TextEditingController();
  List lista_datos = [];
  @override
  void initState() {
    lista_datos = widget.datos;
    print("aqui");
    print(widget.datos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TABLA PERSONAS'),
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
                              .contains(value.toLowerCase()) || element["per_apellido"]
                              .toLowerCase()
                              .contains(value.toLowerCase()) || element["fin_nombre"]
                              .toLowerCase()
                              .contains(value.toLowerCase()) || element["rol_nombre"]
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
                                  'Imagen Finca',
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
                                  'Imagen Persona',
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
                                  'Apellido',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Usuario',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Cedula',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Correo',
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
                                  'Dirección',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Rol',
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
                                                element["fin_imagen"]),
                                          )
                                          ),
                                          DataCell(Text(element["fin_nombre"])),
                                          DataCell(CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                element["per_imagen"]),
                                          )),
                                          DataCell(Text(element["per_nombre"])),
                                          
                                          DataCell(Text(element["per_apellido"])),
                                          DataCell(
                                              Text(element["per_usuario"])),
                                          DataCell(Text(element["per_cedula"])),
                                          DataCell(
                                              Text(element["per_correo"])),
                                          DataCell(Text(element["per_telefono"])),
                                          DataCell(
                                              Text(element["per_direccion"])),
                                          DataCell(
                                              Text(element["rol_nombre"])),
                                          DataCell(
                                            Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 30.0,
                                                  color: Colors.blue,
                                                  onPressed: () async {
                                                    List lista = await getRoles();


                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => IngresarEditarPersona(
                                                              int.parse(element[
                                                                          "per_id"]
                                                                      .toString())
                                                                  as int,
                                                              element[
                                                                  "per_nombre"],
                                                              element[
                                                                  "per_apellido"],
                                                              element[
                                                                  "per_usuario"],
                                                              element[
                                                                  "per_contraseña"],
                                                                  element[
                                                                  "per_imagen"],
                                                                  element[
                                                                  "per_cedula"],
                                                                  element[
                                                                  "per_correo"],
                                                                  element[
                                                                  "per_telefono"],
                                                                  element[
                                                                  "per_direccion"],
                                                                  int.parse(element[
                                                                          "rol_id"]
                                                                      .toString())
                                                                  as int,
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
