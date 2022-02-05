// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class onlyAnimalPage extends StatefulWidget {
  //onlyAnimalPage({Key? key}) : super(key: key);
  List datos_animal;
  onlyAnimalPage(this.datos_animal);
  @override
  _onlyAnimalPageState createState() => _onlyAnimalPageState();
}

class _onlyAnimalPageState extends State<onlyAnimalPage> {
  @override
  Widget build(BuildContext context) {
    //print(widget.datos_animal);
    var queryData = MediaQuery.of(context);
    String _nombrePadre = widget.datos_animal[0]['ani_id_padre_nombre'];
    var _nombreMadre = widget.datos_animal[0]['ani_id_madre_nombre'];
    var _nombreAnimal = widget.datos_animal[0]['ani_nombre'];
    var _codigoAnimal = widget.datos_animal[0]['ani_codigo'];
    var _sexoAnimal = widget.datos_animal[0]['ani_sexo'];
    var _fechaNacimiento = widget.datos_animal[0]['ani_fechanacimiento'];
    var _razaAnimal = widget.datos_animal[0]['ani_raza'];
    var _estadoAnimal =
        widget.datos_animal[0]['ite_id_nombre_etapa'].toString();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  width: queryData.size.width,
                  height: queryData.size.height,
                  //color: Colors.blue[600],
                  padding: EdgeInsets.only(top: 30.0, left: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(widget.datos_animal[0]['ani_imagen']),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                  ),
/*                   child: FaIcon(
                    FontAwesomeIcons.chevronCircleLeft,
                    color: Colors.black,
                    size: 35.0,
                    
                  ), */
                ),
              ),
              Expanded(
                child: Container(
                  //alignment: Alignment.center,
                  color: Colors.blue[50],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Padre',
                                  style: GoogleFonts.questrial(fontSize: 16),
                                ),
                                Text(
                                  _nombrePadre,
                                  style: GoogleFonts.questrial(fontSize: 16),
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(widget
                                      .datos_animal[0]['ani_id_padre_imagen']),
                                  radius: 40,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Madre',
                                  style: GoogleFonts.questrial(fontSize: 16),
                                ),
                                Text(
                                  _nombreMadre,
                                  style: GoogleFonts.questrial(fontSize: 16),
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(widget
                                      .datos_animal[0]['ani_id_madre_imagen']),
                                  radius: 40,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Nombre: $_nombreAnimal',
                        style: GoogleFonts.questrial(fontSize: 18),
                      ),
                      Text(
                        'Codigo: $_codigoAnimal',
                        style: GoogleFonts.questrial(fontSize: 18),
                      ),
                      Text(
                        'Genero: $_sexoAnimal',
                        style: GoogleFonts.questrial(fontSize: 18),
                      ),
                      Text(
                        'Fecha Nacimiento: $_fechaNacimiento',
                        style: GoogleFonts.questrial(fontSize: 18),
                      ),
                      Text(
                        'Raza: $_razaAnimal',
                        style: GoogleFonts.questrial(fontSize: 18),
                      ),
                      Text(
                        'Estado animal: $_estadoAnimal',
                        style: GoogleFonts.questrial(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
